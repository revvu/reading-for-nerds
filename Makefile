APP := .build/ReadingForNerds.app
# A stable signing identity keeps the Accessibility grant across rebuilds; ad-hoc signing resets it every build.
SIGN ?= $(or $(shell security find-identity -p codesigning -v | awk -F'"' '/Apple Development/ {print $$2; exit}'),-)

.PHONY: app install test

app:
	swift build -c release
	rm -rf $(APP) && mkdir -p $(APP)/Contents/MacOS
	cp .build/release/ReadingForNerds $(APP)/Contents/MacOS/
	cp Info.plist $(APP)/Contents/
	codesign --force --sign "$(SIGN)" $(APP)

install: app
	pkill -x ReadingForNerds || true
	rm -rf ~/Applications/ReadingForNerds.app
	cp -R $(APP) ~/Applications/
	open ~/Applications/ReadingForNerds.app

test:
	swift test
