import AppKit
import Carbon.HIToolbox

/// Reads the text highlighted in whichever app is in front by pressing ⌘C on its behalf.
/// Copy works in nearly every app, unlike the Accessibility API's selected-text attribute,
/// which each app must choose to fill in. The clipboard is put back afterwards.
@MainActor
enum Selection {
    /// Posting a keystroke into another app needs the Accessibility permission.
    static var allowed: Bool { AXIsProcessTrusted() }

    static func askForPermission() {
        let prompt = "AXTrustedCheckOptionPrompt" as CFString
        AXIsProcessTrustedWithOptions([prompt: true] as CFDictionary)
    }

    static func copy() async -> String? {
        let pasteboard = NSPasteboard.general
        let saved = snapshot(pasteboard)
        let before = pasteboard.changeCount

        pressCommandC()
        for _ in 0..<30 where pasteboard.changeCount == before {
            try? await Task.sleep(for: .milliseconds(10))
        }
        guard pasteboard.changeCount != before else { return nil }

        let text = pasteboard.string(forType: .string)
        pasteboard.clearContents()
        pasteboard.writeObjects(saved)
        return text
    }

    private static func pressCommandC() {
        let source = CGEventSource(stateID: .combinedSessionState)
        // Keep the user's still-held hotkey modifiers out of the posted keystroke.
        source?.setLocalEventsFilterDuringSuppressionState([.permitLocalMouseEvents, .permitSystemDefinedEvents],
                                                           state: .eventSuppressionStateSuppressionInterval)
        for down in [true, false] {
            let event = CGEvent(keyboardEventSource: source, virtualKey: CGKeyCode(kVK_ANSI_C), keyDown: down)
            event?.flags = .maskCommand
            event?.post(tap: .cgSessionEventTap)
        }
    }

    private static func snapshot(_ pasteboard: NSPasteboard) -> [NSPasteboardItem] {
        (pasteboard.pasteboardItems ?? []).map { item in
            let copy = NSPasteboardItem()
            for type in item.types {
                if let data = item.data(forType: type) { copy.setData(data, forType: type) }
            }
            return copy
        }
    }
}
