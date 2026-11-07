import AppKit
import ReaderCore

/// Draws one word with its pivot letter at a fixed point, so the eye never moves.
final class ReaderView: NSView {
    enum Content {
        case word(Word)
        case message(String, detail: String?)
    }

    var content: Content = .message("", detail: nil) { didSet { needsDisplay = true } }
    var wpm = 0 { didSet { needsDisplay = true } }
    var progress = 0.0 { didSet { needsDisplay = true } }
    var paused = false { didSet { needsDisplay = true } }

    private let wordSize: CGFloat = 52
    private let guideGap: CGFloat = 46

    /// The pivot sits left of centre because words run further right of their pivot than left.
    private var pivotX: CGFloat { (bounds.width * 0.38).rounded() }

    override func draw(_ dirtyRect: NSRect) {
        let card = NSBezierPath(roundedRect: bounds, xRadius: 18, yRadius: 18)
        NSColor.windowBackgroundColor.setFill()
        card.fill()
        card.addClip()

        switch content {
        case .word(let word):
            drawGuides()
            drawWord(word)
            drawFooter()
        case .message(let title, let detail):
            drawMessage(title, detail: detail)
        }
    }

    private func drawGuides() {
        NSColor.separatorColor.setFill()
        for y in [bounds.midY + guideGap, bounds.midY - guideGap - 1] {
            NSRect(x: 40, y: y, width: bounds.width - 80, height: 1).fill()
        }
        NSColor.tertiaryLabelColor.setFill()
        NSRect(x: pivotX - 1, y: bounds.midY + guideGap - 12, width: 2, height: 12).fill()
        NSRect(x: pivotX - 1, y: bounds.midY - guideGap, width: 2, height: 12).fill()
    }

    private func drawWord(_ word: Word) {
        let chars = Array(word.text)
        let before = String(chars[..<word.pivot])
        let pivot = String(chars[word.pivot])
        let after = String(chars[(word.pivot + 1)...])

        // Shrink only words that would run past the guides on either side of the pivot.
        var font = NSFont.systemFont(ofSize: wordSize, weight: .medium)
        let half = width(pivot, font) / 2
        let scale = min(1, (pivotX - 40) / (width(before, font) + half), (bounds.width - 40 - pivotX) / (width(after, font) + half))
        if scale < 1 { font = NSFont.systemFont(ofSize: (wordSize * scale).rounded(.down), weight: .medium) }

        let pivotWidth = width(pivot, font)
        let x = pivotX - width(before, font) - pivotWidth / 2
        // Centre the capital height on the guides' midline.
        let y = bounds.midY - font.capHeight / 2 + font.descender

        let text = NSMutableAttributedString()
        text.append(styled(before, font, .labelColor))
        text.append(styled(pivot, font, .systemRed))
        text.append(styled(after, font, .labelColor))
        text.draw(at: NSPoint(x: x, y: y))
    }

    private func drawFooter() {
        let font = NSFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular)
        styled("\(wpm) wpm", font, .tertiaryLabelColor).draw(at: NSPoint(x: 20, y: 14))
        if paused {
            let label = styled("Paused · Space to resume", font, .secondaryLabelColor)
            label.draw(at: NSPoint(x: bounds.width - 20 - label.size().width, y: 14))
        }
        NSColor.controlAccentColor.setFill()
        NSRect(x: 0, y: 0, width: bounds.width * progress, height: 3).fill()
    }

    private func drawMessage(_ title: String, detail: String?) {
        let titleText = styled(title, .systemFont(ofSize: 20, weight: .semibold), .labelColor)
        let detailText = styled(detail ?? "", .systemFont(ofSize: 13), .secondaryLabelColor)
        let gap: CGFloat = detail == nil ? 0 : 8
        let total = titleText.size().height + gap + (detail == nil ? 0 : detailText.size().height)
        let top = bounds.midY + total / 2
        titleText.draw(at: NSPoint(x: bounds.midX - titleText.size().width / 2, y: top - titleText.size().height))
        detailText.draw(at: NSPoint(x: bounds.midX - detailText.size().width / 2, y: top - total))
    }

    private func styled(_ s: String, _ font: NSFont, _ color: NSColor) -> NSAttributedString {
        NSAttributedString(string: s, attributes: [.font: font, .foregroundColor: color])
    }

    private func width(_ s: String, _ font: NSFont) -> CGFloat {
        styled(s, font, .labelColor).size().width
    }
}
