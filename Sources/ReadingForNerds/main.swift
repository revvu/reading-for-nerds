import AppKit

/// Menu-bar app: the hotkey copies the selection and hands it to the reader.
@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private let reader = Reader()
    private var hotkey: Hotkey!
    private var statusItem: NSStatusItem!
    private let readItem = NSMenuItem(title: "Read Selection", action: #selector(readSelection), keyEquivalent: "")

    func applicationDidFinishLaunching(_ notification: Notification) {
        hotkey = Hotkey { [weak self] in self?.readSelection() }

        let menu = NSMenu()
        readItem.target = self
        menu.addItem(readItem)
        menu.addItem(withTitle: "Change Shortcut…", action: #selector(changeShortcut), keyEquivalent: "").target = self
        menu.addItem(.separator())
        menu.addItem(withTitle: "Quit Reading for Nerds", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusItem.button?.image = NSImage(systemSymbolName: "eyeglasses", accessibilityDescription: "Reading for Nerds")
        statusItem.menu = menu

        use(Shortcut.saved)
        if !Selection.allowed { Selection.askForPermission() }
    }

    private func use(_ shortcut: Shortcut) {
        readItem.keyEquivalent = shortcut.key == "Space" ? " " : shortcut.key.lowercased()
        readItem.keyEquivalentModifierMask = shortcut.modifiers
        if !hotkey.register(shortcut) {
            reader.show("\(shortcut.label) is already taken", detail: "Pick another from the menu bar: Change Shortcut…")
        }
    }

    @objc private func readSelection() {
        if reader.isOpen { return reader.close() }
        guard Selection.allowed else {
            Selection.askForPermission()
            return reader.show("Reading for Nerds needs Accessibility access",
                               detail: "System Settings → Privacy & Security → Accessibility")
        }
        Task {
            guard let text = await Selection.copy(), !text.allSatisfy(\.isWhitespace) else {
                return reader.show("Nothing selected", detail: "Highlight some text, then press \(Shortcut.saved.label).")
            }
            reader.read(text)
        }
    }

    @objc private func changeShortcut() {
        hotkey.unregister()
        reader.record { [weak self] shortcut in
            if let shortcut { Shortcut.saved = shortcut }
            self?.use(Shortcut.saved)
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)
app.run()
