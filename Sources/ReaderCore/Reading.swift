import Foundation

/// One word as the reader shows it.
public struct Word: Equatable, Sendable {
    public let text: String
    /// Index of the character the eye fixes on; it is drawn at the same screen point for every word.
    public let pivot: Int
    /// How long the word stays up, in multiples of one beat (60 / wpm seconds).
    public let weight: Double
    public let endsSentence: Bool
}

public enum Reading {
    public static func words(in text: String) -> [Word] {
        let paragraphs = text.components(separatedBy: "\n").split(whereSeparator: { $0.allSatisfy(\.isWhitespace) })
        return paragraphs.flatMap { lines -> [Word] in
            let tokens = lines.joined(separator: " ").split(whereSeparator: \.isWhitespace).map(String.init)
            return tokens.enumerated().map { i, token in
                var word = word(token)
                if i == tokens.count - 1 {
                    word = Word(text: word.text, pivot: word.pivot, weight: max(word.weight, 2.5), endsSentence: true)
                }
                return word
            }
        }
    }

    static func word(_ token: String) -> Word {
        let chars = Array(token)
        let leading = chars.prefix(while: { !isCore($0) }).count
        let trailing = chars.reversed().prefix(while: { !isCore($0) }).count
        let core = max(chars.count - leading - trailing, 0)
        let pivot = core == 0 ? 0 : leading + recognitionPoint(length: core)

        let tail = String(chars.suffix(trailing))
        let endsSentence = tail.contains(where: { ".!?…".contains($0) })
        let endsClause = tail.contains(where: { ",;:—–".contains($0) })
        let pause = endsSentence ? 2.0 : endsClause ? 1.5 : 1.0
        let length = core > 8 ? 1.3 : 1.0
        return Word(text: token, pivot: pivot, weight: pause * length, endsSentence: endsSentence)
    }

    /// Where in a word the eye recognises it fastest: a little left of centre, per Spritz's published rule of thumb.
    static func recognitionPoint(length: Int) -> Int {
        switch length {
        case ...1: 0
        case ...5: 1
        case ...9: 2
        case ...13: 3
        default: 4
        }
    }

    private static func isCore(_ c: Character) -> Bool { c.isLetter || c.isNumber }

    /// Start of the sentence holding word `i`.
    public static func sentenceStart(of i: Int, in words: [Word]) -> Int {
        guard i > 0 else { return 0 }
        return (words[..<i].lastIndex(where: \.endsSentence) ?? -1) + 1
    }

    /// Back to the start of this sentence, or of the previous one when already at the start.
    public static func previousSentence(from i: Int, in words: [Word]) -> Int {
        let start = sentenceStart(of: i, in: words)
        if i - start > 1 || start == 0 { return start }
        return sentenceStart(of: start - 1, in: words)
    }

    public static func nextSentence(from i: Int, in words: [Word]) -> Int {
        guard let end = words[i...].firstIndex(where: \.endsSentence) else { return words.count - 1 }
        return min(end + 1, words.count - 1)
    }
}

/// Words joined into one string for a speech voice, with each word's start, so the voice's
/// "now saying this range" reports map back to the word on screen.
public struct SpokenText: Sendable {
    public let text: String
    private let starts: [Int] // UTF-16 offsets, the unit speech ranges use

    public init(_ words: ArraySlice<Word>) {
        var starts: [Int] = []
        var offset = 0
        for word in words {
            starts.append(offset)
            offset += word.text.utf16.count + 1
        }
        self.text = words.map(\.text).joined(separator: " ")
        self.starts = starts
    }

    /// Position, within these words, of the word holding `offset`. A voice may split one word
    /// into several ranges ("well-known"); every part maps to the same word.
    public func word(at offset: Int) -> Int {
        starts.lastIndex { $0 <= offset } ?? 0
    }
}
