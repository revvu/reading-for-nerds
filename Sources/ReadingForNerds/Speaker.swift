import AVFoundation
import ReaderCore

/// Reads words aloud with macOS's own voices and reports each word as the voice starts it,
/// so the voice, not a timer, sets the pace.
@MainActor
final class Speaker: NSObject {
    var onWord: ((Int) -> Void)?
    var onFinish: (() -> Void)?

    private let synthesizer = AVSpeechSynthesizer()
    private var current: (utterance: ObjectIdentifier, spoken: SpokenText, first: Int)?

    /// The voice's own rate scale (0–1, 0.5 normal); Apple doesn't map it to words per minute.
    var rate: Float {
        get { UserDefaults.standard.object(forKey: "voiceRate") as? Float ?? AVSpeechUtteranceDefaultSpeechRate }
        set { UserDefaults.standard.set(min(max(newValue, 0.3), 1), forKey: "voiceRate") }
    }

    /// A downloaded Premium or Enhanced voice in the system language, else that language's default voice.
    private let voice: AVSpeechSynthesisVoice? = {
        let language = AVSpeechSynthesisVoice.currentLanguageCode()
        let downloaded = AVSpeechSynthesisVoice.speechVoices().filter { $0.language == language && $0.quality != .default }
        return downloaded.max { $0.quality.rawValue < $1.quality.rawValue } ?? AVSpeechSynthesisVoice(language: language)
    }()

    override init() {
        super.init()
        synthesizer.delegate = self
        // Load the voice now: a cold voice takes seconds to say its first word, a warm one about 0.1s.
        let warmUp = AVSpeechUtterance(string: ".")
        warmUp.voice = voice
        warmUp.volume = 0
        synthesizer.speak(warmUp)
    }

    func speak(_ words: [Word], from first: Int) {
        stop()
        let spoken = SpokenText(words[first...])
        let utterance = AVSpeechUtterance(string: spoken.text)
        utterance.voice = voice
        utterance.rate = rate
        current = (ObjectIdentifier(utterance), spoken, first)
        synthesizer.speak(utterance)
    }

    func stop() {
        current = nil
        synthesizer.stopSpeaking(at: .immediate)
    }

    // Callbacks from an utterance that was since stopped are ignored.
    private func said(_ utterance: ObjectIdentifier, offset: Int) {
        guard let current, current.utterance == utterance else { return }
        onWord?(current.first + current.spoken.word(at: offset))
    }

    private func finished(_ utterance: ObjectIdentifier) {
        guard current?.utterance == utterance else { return }
        current = nil
        onFinish?()
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString range: NSRange, utterance: AVSpeechUtterance) {
        let id = ObjectIdentifier(utterance)
        DispatchQueue.main.async { MainActor.assumeIsolated { self.said(id, offset: range.location) } }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let id = ObjectIdentifier(utterance)
        DispatchQueue.main.async { MainActor.assumeIsolated { self.finished(id) } }
    }
}
