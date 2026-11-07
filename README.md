# Reading for Nerds

Highlight text anywhere on the Mac, press a hotkey, and read it word by word at one fixed point on screen.
Each word is drawn with its recognition letter, in red, on the same spot, so your eyes never move.

## Use

- **⌃⌥R** reads the selection; press it again to close. Change it from the menu-bar glasses: Change Shortcut….
- **Space** pauses, **↑ / ↓** change speed by 25 wpm, **← / →** jump a sentence, **Esc** closes.
- The first run asks for Accessibility access, which it needs to press ⌘C for you.

## Build

```sh
make install   # builds, signs, copies to ~/Applications and launches
make test
```

No dependencies: three files, one per layer.

- `Hotkey.swift`: Carbon's `RegisterEventHotKey`, the one macOS API that claims a single key combination system-wide without a permission.
- `Selection.swift`: posts ⌘C to the front app and restores your clipboard; copy works in nearly every app, where the Accessibility API's selected text does not.
- `Reader.swift` and `ReaderView.swift`: a floating panel that takes keys without stealing focus, and draws each word around its pivot.
- `ReaderCore`: the tested rules for where the pivot falls and how long each word stays up.
