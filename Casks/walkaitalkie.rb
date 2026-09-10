# Homebrew cask for WalkAITalkie, the macOS menu bar push-to-talk speech-recognition
# app with on-device LLM post-processing (Direct/Sparkle channel, not the App Store build).
# Published to the personal tap Kanevry/homebrew-walkaitalkie (brew tap kanevry/walkaitalkie).
#
# `version` and `sha256` are bumped by scripts/update-homebrew-cask.sh in the main repo
# AFTER a Sparkle release has been published. The URL is deliberately the VERSIONED
# DMG, never .../WalkAITalkie-latest.dmg -- Homebrew needs a stable checksum per version.
cask "walkaitalkie" do
  version "2.6.0"
  sha256 "9e5abdfb54cf0e49f646bd369d5a95b9f7b464fc63a5696c7d17bd39f70ade74"

  url "https://oj0jtcebfrfsieei.public.blob.vercel-storage.com/releases/WalkAITalkie-v#{version}.dmg",
      verified: "oj0jtcebfrfsieei.public.blob.vercel-storage.com/releases/"
  name "WalkAITalkie"
  desc "Menu bar push-to-talk dictation with on-device speech recognition and LLM cleanup"
  homepage "https://walkaitalkie.com"

  # Same Sparkle appcast the shipped app updates from (SUFeedURL in Info.plist).
  livecheck do
    url "https://oj0jtcebfrfsieei.public.blob.vercel-storage.com/releases/appcast.xml"
    strategy :sparkle
  end

  # LSMinimumSystemVersion in the shipped bundle is 26.0 (MACOSX_DEPLOYMENT_TARGET).
  depends_on macos: ">= :tahoe"

  app "WalkAITalkie.app"

  uninstall quit: "at.buchhaltgenie.walkaitalkie"

  # NOTE: downloaded speech/LLM models are deliberately NOT zapped. They live in
  # ~/Documents/huggingface/models/ (swift-transformers HubApi path), are multi-GB,
  # and are shared with any other MLX/WhisperKit tooling on the machine. Deleting
  # user Documents from a `brew zap` would be hostile and would fail `brew audit`.
  zap trash: [
    "~/Library/Application Support/WalkAITalkie",
    "~/Library/Caches/at.buchhaltgenie.walkaitalkie",
    "~/Library/Caches/at.buchhaltgenie.walkaitalkie.ShipIt",
    "~/Library/HTTPStorages/at.buchhaltgenie.walkaitalkie",
    "~/Library/Preferences/at.buchhaltgenie.walkaitalkie.plist",
    "~/Library/Saved Application State/at.buchhaltgenie.walkaitalkie.savedState",
  ]
end
