import AppKit
import Carbon.HIToolbox
import ReaderCore

/// A floating panel that takes keystrokes without pulling focus from the app being read.
final class ReaderPanel: NSPanel {
    var onKey: ((NSEvent) -> Void)?
    var onResignKey: (() -> Void)?

    init() {
        super.init(contentRect: NSRect(x: 0, y: 0, width: 640, height: 220),
                   styleMask: [.borderless, .nonactivatingPanel], backing: .buffered, defer: true)
        isFloatingPanel = true
        level = .statusBar
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        backgroundColor = .clear
        isOpaque = false
        hasShadow = true
        hidesOnDeactivate = false
    }

    override var canBecomeKey: Bool { true }

    // Every key, ⌘ combinations included, goes to the reader.
    override func sendEvent(_ event: NSEvent) {
        if event.type == .keyDown { onKey?(event) } else { super.sendEvent(event) }
    }

    override func resignKey() {
        super.resignKey()
        onResignKey?()
    }
}

/// The pace comes from a timer, or, with the voice on, from the voice reaching each word.
@MainActor
final class Reader {
    private let panel = ReaderPanel()
    private let view = ReaderView()
    private let speaker = Speaker()
    private var words: [Word] = []
    private var index = 0
    private var timer: Timer?
    private var recording: ((Shortcut?) -> Void)?
    /// Where and when the voice last started, to measure how fast it is really going.
    private var voiceStart: (index: Int, time: Date)?

    var isOpen: Bool { panel.isVisible }

    private var wpm: Int {
        get { UserDefaults.standard.object(forKey: "wpm") as? Int ?? 400 }
        set { UserDefaults.standard.set(min(max(newValue, 100), 1500), forKey: "wpm") }
    }

    private var voiceOn: Bool {
        get { UserDefaults.standard.bool(forKey: "voice") }
        set { UserDefaults.standard.set(newValue, forKey: "voice") }
    }

    init() {
        panel.contentView = view
        panel.onKey = { [weak self] in self?.key($0) }
        panel.onResignKey = { [weak self] in self?.close() }
        speaker.onWord = { [weak self] in self?.voiceReached($0) }
        speaker.onFinish = { [weak self] in self?.finishSoon() }
    }

    func read(_ text: String) {
        words = Reading.words(in: text)
        guard !words.isEmpty else { return show("Nothing to read") }
        index = 0
        view.paused = false
        open()
        render()
        play(extra: 0.4) // a beat for the eye to land on the first word
    }

    func show(_ title: String, detail: String? = nil) {
        halt()
        view.content = .message(title, detail: detail)
        open()
        timer = .scheduledTimer(withTimeInterval: 2.5, repeats: false) { [weak self] _ in
            MainActor.assumeIsolated { self?.close() }
        }
    }

    func record(_ done: @escaping (Shortcut?) -> Void) {
        show("Press the new shortcut", detail: "Use ⌃, ⌥ or ⌘ with a key.  Esc cancels.")
        halt()
        recording = done
    }

    func close() {
        guard panel.isVisible else { return }
        halt()
        panel.orderOut(nil)
        finishRecording(nil)
    }

    private func open() {
        let screen = NSScreen.screens.first { NSMouseInRect(NSEvent.mouseLocation, $0.frame, false) } ?? NSScreen.main
        if let frame = screen?.visibleFrame {
            let size = panel.frame.size
            panel.setFrameOrigin(NSPoint(x: frame.midX - size.width / 2, y: frame.midY - size.height / 2 + frame.height * 0.08))
        }
        panel.makeKeyAndOrderFront(nil)
    }

    private func render() {
        view.content = .word(words[index])
        view.progress = Double(index + 1) / Double(words.count)
        view.status = voiceOn ? voiceStatus : "\(wpm) wpm"
    }

    /// The voice's real speed once it has said enough words to measure; its rate setting has no wpm scale.
    private var voiceStatus: String {
        guard let start = voiceStart, index - start.index >= 6 else { return "Voice" }
        let measured = Double(index - start.index) / Date().timeIntervalSince(start.time) * 60
        return "Voice · \(Int((measured / 10).rounded()) * 10) wpm"
    }

    private func play(extra: TimeInterval = 0) {
        halt()
        if voiceOn {
            voiceStart = (index, Date())
            speaker.speak(words, from: index)
        } else {
            schedule(extra: extra)
        }
        render()
    }

    private func schedule(extra: TimeInterval) {
        let seconds = 60 / Double(wpm) * words[index].weight + extra
        timer = .scheduledTimer(withTimeInterval: seconds, repeats: false) { [weak self] _ in
            MainActor.assumeIsolated { self?.advance() }
        }
    }

    private func advance() {
        guard index + 1 < words.count else { return close() }
        index += 1
        render()
        schedule(extra: 0)
    }

    private func voiceReached(_ word: Int) {
        index = min(word, words.count - 1)
        render()
    }

    private func finishSoon() {
        timer = .scheduledTimer(withTimeInterval: 0.4, repeats: false) { [weak self] _ in
            MainActor.assumeIsolated { self?.close() }
        }
    }

    private func halt() {
        timer?.invalidate()
        timer = nil
        speaker.stop()
    }

    private func finishRecording(_ shortcut: Shortcut?) {
        let done = recording
        recording = nil
        done?(shortcut)
    }

    private func key(_ event: NSEvent) {
        if recording != nil {
            if Int(event.keyCode) == kVK_Escape { return close() }
            guard let shortcut = Shortcut(event: event) else { return NSSound.beep() }
            finishRecording(shortcut)
            return close()
        }
        guard case .word = view.content else { return close() }

        switch Int(event.keyCode) {
        case kVK_Escape:
            close()
        case kVK_Space:
            view.paused.toggle()
            view.paused ? halt() : play()
        case kVK_ANSI_V:
            voiceOn.toggle()
            view.paused ? render() : play()
        case kVK_UpArrow, kVK_DownArrow:
            let up = Int(event.keyCode) == kVK_UpArrow
            if voiceOn {
                speaker.rate += up ? 0.05 : -0.05
                if !view.paused { play() } // a voice's rate is fixed per utterance, so restart at this word
            } else {
                wpm += up ? 25 : -25
                render()
            }
        case kVK_LeftArrow, kVK_RightArrow:
            index = Int(event.keyCode) == kVK_LeftArrow
                ? Reading.previousSentence(from: index, in: words)
                : Reading.nextSentence(from: index, in: words)
            view.paused ? render() : play(extra: 0.3)
        default:
            break
        }
    }
}
