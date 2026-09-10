# homebrew-walkaitalkie

Homebrew tap for [WalkAITalkie](https://walkaitalkie.com), the macOS menu bar
push-to-talk dictation app with on-device speech recognition and LLM cleanup.

## Install

```sh
brew tap kanevry/walkaitalkie
brew install --cask walkaitalkie
```

This installs the signed, notarized and stapled `WalkAITalkie.app` from the Direct
(Sparkle) distribution channel into `/Applications`. It is the same build the
website serves; the App Store build is a separate, non-Homebrew channel.

Requires macOS 26 (Tahoe) or newer.

After install, launch the app once and grant Microphone and Accessibility access
when asked. Speech and LLM models are downloaded on first use.

## Update

The app updates itself via Sparkle. To update through Homebrew instead:

```sh
brew update && brew upgrade --cask walkaitalkie
```

## Uninstall

```sh
brew uninstall --cask walkaitalkie
# optional: also remove settings, caches and history
brew uninstall --zap --cask walkaitalkie
```

`--zap` deliberately leaves the downloaded speech/LLM models in
`~/Documents/huggingface/models/` alone — they are multi-gigabyte and shared with
other MLX/WhisperKit tooling.

## Updating the cask

The cask is bumped from the main repo after a Sparkle release is published:

```sh
scripts/update-homebrew-cask.sh <version> --dry-run   # inspect
scripts/update-homebrew-cask.sh <version>             # patch, commit, push
```

It downloads the versioned DMG, verifies `CFBundleShortVersionString` matches,
computes the sha256 and pushes the result here. See `docs/homebrew.md` in the
main repo.

## License

MIT — see [LICENSE](LICENSE).
