import AppKit
import Carbon.HIToolbox

/// A key combination the user picked, saved in UserDefaults.
struct Shortcut: Equatable {
    var keyCode: UInt32
    var modifiers: NSEvent.ModifierFlags
    var key: String

    static let standard = Shortcut(keyCode: UInt32(kVK_ANSI_R), modifiers: [.control, .option], key: "R")

    var label: String {
        let symbols: [(NSEvent.ModifierFlags, String)] = [(.control, "⌃"), (.option, "⌥"), (.shift, "⇧"), (.command, "⌘")]
        return symbols.filter { modifiers.contains($0.0) }.map(\.1).joined() + key
    }

    var carbonModifiers: UInt32 {
        let pairs: [(NSEvent.ModifierFlags, Int)] = [(.command, cmdKey), (.option, optionKey), (.control, controlKey), (.shift, shiftKey)]
        return pairs.reduce(0) { modifiers.contains($1.0) ? $0 | UInt32($1.1) : $0 }
    }

    init(keyCode: UInt32, modifiers: NSEvent.ModifierFlags, key: String) {
        self.keyCode = keyCode
        self.modifiers = modifiers.intersection([.control, .option, .shift, .command])
        self.key = key
    }

    /// A shortcut from a key press, or nil when it has no ⌃, ⌥ or ⌘ and would steal ordinary typing.
    init?(event: NSEvent) {
        let modifiers = event.modifierFlags.intersection([.control, .option, .shift, .command])
        guard !modifiers.intersection([.control, .option, .command]).isEmpty else { return nil }
        let key = event.keyCode == kVK_Space ? "Space" : (event.charactersIgnoringModifiers ?? "?").uppercased()
        self.init(keyCode: UInt32(event.keyCode), modifiers: modifiers, key: key)
    }

    static var saved: Shortcut {
        get {
            let d = UserDefaults.standard
            guard let key = d.string(forKey: "shortcutKey") else { return .standard }
            return Shortcut(keyCode: UInt32(d.integer(forKey: "shortcutKeyCode")),
                            modifiers: NSEvent.ModifierFlags(rawValue: UInt(d.integer(forKey: "shortcutModifiers"))),
                            key: key)
        }
        set {
            let d = UserDefaults.standard
            d.set(Int(newValue.keyCode), forKey: "shortcutKeyCode")
            d.set(Int(newValue.modifiers.rawValue), forKey: "shortcutModifiers")
            d.set(newValue.key, forKey: "shortcutKey")
        }
    }
}

/// A system-wide hotkey through Carbon's RegisterEventHotKey: the one macOS API that claims a single
/// key combination for this app, swallows it from other apps, and needs no permission.
@MainActor
final class Hotkey {
    private var ref: EventHotKeyRef?
    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
        var pressed = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        InstallEventHandler(GetApplicationEventTarget(), { _, _, context in
            let hotkey = Unmanaged<Hotkey>.fromOpaque(context!).takeUnretainedValue()
            MainActor.assumeIsolated { hotkey.action() }
            return noErr
        }, 1, &pressed, Unmanaged.passUnretained(self).toOpaque(), nil)
    }

    /// False when macOS refuses the combination, e.g. one another app already holds.
    @discardableResult
    func register(_ shortcut: Shortcut) -> Bool {
        unregister()
        let id = EventHotKeyID(signature: OSType(0x5246_4E52), id: 1) // "RFNR"
        return RegisterEventHotKey(shortcut.keyCode, shortcut.carbonModifiers, id, GetApplicationEventTarget(), 0, &ref) == noErr
    }

    func unregister() {
        if let ref { UnregisterEventHotKey(ref) }
        ref = nil
    }
}
