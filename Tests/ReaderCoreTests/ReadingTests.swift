import Testing
@testable import ReaderCore

@Test func pivotSitsLeftOfCentre() {
    #expect(Reading.word("a").pivot == 0)
    #expect(Reading.word("read").pivot == 1)
    #expect(Reading.word("reading").pivot == 2)
    #expect(Reading.word("recognition").pivot == 3)
    #expect(Reading.word("incomprehensibly").pivot == 4)
}

@Test func pivotSkipsLeadingPunctuation() {
    #expect(Reading.word("\"Hello,").pivot == 2)
    #expect(Reading.word("—").pivot == 0)
}

@Test func punctuationAndLengthSlowTheWordDown() {
    #expect(Reading.word("word").weight == 1.0)
    #expect(Reading.word("word,").weight == 1.5)
    #expect(Reading.word("word.").weight == 2.0)
    #expect(Reading.word("word.\"").endsSentence)
    #expect(Reading.word("extraordinary").weight == 1.3)
}

@Test func paragraphEndsGetTheLongestPause() {
    let words = Reading.words(in: "One two\nthree.\n\n  \nFour five")
    #expect(words.map(\.text) == ["One", "two", "three.", "Four", "five"])
    #expect(words[2].weight == 2.5)
    #expect(words[4].endsSentence)
}

@Test func sentenceNavigation() {
    let words = Reading.words(in: "A b c. D e f. G h.")
    #expect(Reading.sentenceStart(of: 4, in: words) == 3)
    #expect(Reading.previousSentence(from: 5, in: words) == 3)
    #expect(Reading.previousSentence(from: 4, in: words) == 0)
    #expect(Reading.previousSentence(from: 1, in: words) == 0)
    #expect(Reading.nextSentence(from: 1, in: words) == 3)
    #expect(Reading.nextSentence(from: 7, in: words) == 7)
}
