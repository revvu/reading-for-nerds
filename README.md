# Reading for Nerds

Highlight text anywhere on the Mac, press a hotkey, and read it word by word at one fixed point on screen.
Each word is drawn with its recognition letter, in red, on the same spot, so your eyes never move.

## Install

You need macOS 14 or later and Apple's Command Line Tools.
If `swift --version` prints a version, you have them; otherwise run `xcode-select --install`.

1. Clone and install:

   ```sh
   git clone https://github.com/revvu/reading-for-nerds.git
   cd reading-for-nerds
   make install
   ```

   This builds the app, copies it to `~/Applications` and launches it.
   A glasses icon appears in the menu bar.

2. Highlight some text and press the hotkey: hold **Control** and **Option**, then tap **R** (written ⌃⌥R).

3. The first time, macOS asks for Accessibility access, which the app needs to copy your selection.
   Turn on **ReadingForNerds** in System Settings → Privacy & Security → Accessibility, then press the hotkey again.

To update, run `git pull && make install`.
To uninstall, quit from the menu bar and delete `~/Applications/ReadingForNerds.app`.

### If something goes wrong

- **`make install` fails with "Invalid manifest"**: some Command Line Tools installs keep stale files from an older version. Remove them, then run `make install` again:

  ```sh
  sudo rm /Library/Developer/CommandLineTools/usr/lib/swift/pm/ManifestAPI/PackageDescription.swiftmodule/*.private.swiftinterface
  ```

- **The hotkey stops working after a rebuild**: without an Apple Development certificate the app is signed ad hoc, and macOS forgets the Accessibility grant on every build. Remove ReadingForNerds from the Accessibility list, add it again, and relaunch.
- **"Nothing selected"**: the front app didn't copy anything. Make sure the text is highlighted and that the app allows copying.

## Use

| Key | Action |
|---|---|
| ⌃⌥R | Read the selection; press again to close |
| Space | Pause or resume |
| ↑ / ↓ | Speed up or slow down by 25 wpm |
| ← / → | Jump back or forward a sentence |
| V | Turn the voice on or off |
| Esc | Close |

With the voice on, words appear as the voice says them, and ↑ / ↓ change how fast it talks.
The footer shows the speed it is actually reaching.
The voice is the best one installed for your system language.
For a much better one, download a Premium or Enhanced voice in System Settings → Accessibility → Spoken Content → System Voice → Manage Voices, then relaunch the app.

To change the hotkey, click the glasses icon in the menu bar, choose **Change Shortcut…**, and press the new combination.

## How it works

No dependencies: one file per layer.

- `Hotkey.swift`: Carbon's `RegisterEventHotKey`, the one macOS API that claims a single key combination system-wide without a permission.
- `Selection.swift`: posts ⌘C to the front app and restores your clipboard; copy works in nearly every app, where the Accessibility API's selected text does not.
- `Speaker.swift`: macOS's own voices (`AVSpeechSynthesizer`), which report each word as they start it, so the voice sets the pace.
- `Reader.swift` and `ReaderView.swift`: a floating panel that takes keys without stealing focus, and draws each word around its pivot.
- `ReaderCore`: the tested rules for where the pivot falls and how long each word stays up. Run them with `make test`.
