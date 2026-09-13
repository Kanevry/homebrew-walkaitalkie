# Homebrew cask for WalkAITalkie, the macOS menu bar push-to-talk speech-recognition
# app with on-device LLM post-processing (Direct/Sparkle channel, not the App Store build).
# Published to the personal tap Kanevry/homebrew-walkaitalkie (brew tap kanevry/walkaitalkie).
#
# `version` and `sha256` are bumped by scripts/update-homebrew-cask.sh in the main repo
# AFTER a Sparkle release has been published. The URL is deliberately the VERSIONED
# DMG, never .../WalkAITalkie-latest.dmg -- Homebrew needs a stable checksum per version.
cask "walkaitalkie" do
  version "2.8.2"
  sha256 "e5da1688c5edf3ce9feba2796625dabfb4abe08322957cf9680e7e737bd73e15"

  url "https://oj0jtcebfrfsieei.public.blob.vercel-storage.com/releases/WalkAITalkie-v#{version}.dmg"
  name "WalkAITalkie"
  desc "Menu bar push-to-talk dictation with on-device speech recognition"
  homepage "https://walkaitalkie.com/"

  # Same Sparkle appcast the shipped app updates from (SUFeedURL in Info.plist).
  # The appcast carries both sparkle:shortVersionString (2.6.0) and sparkle:version
  # (build 30). The default :sparkle strategy would report "2.6.0,30"; the cask
  # tracks the marketing version only, because that is what the DMG filename uses.
  livecheck do
    url "https://oj0jtcebfrfsieei.public.blob.vercel-storage.com/releases/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # LSMinimumSystemVersion in the shipped bundle is 26.0 (MACOSX_DEPLOYMENT_TARGET).
  # Homebrew 6 reads a bare symbol as ">= that release"; the string form is deprecated.
  depends_on macos: :tahoe

  app "WalkAITalkie.app"

  uninstall quit: "at.buchhaltgenie.walkaitalkie"

  # Paths below were verified to exist on a real install (Direct/Sparkle build).
  # The Sparkle update cache lives inside .../Caches/at.buchhaltgenie.walkaitalkie/
  # org.sparkle-project.Sparkle and is covered by the Caches entry.
  #
  # Deliberately NOT zapped:
  #  * ~/Documents/huggingface/models/ -- downloaded speech/LLM models. Multi-GB,
  #    shared with any other MLX/WhisperKit tooling, and inside the user's Documents.
  #    Removing those from a `brew zap` would be hostile.
  #  * ~/Library/Containers/at.buchhaltgenie.walkaitalkie -- belongs to the sandboxed
  #    App Store build, which Homebrew does not install and must not touch.
  zap trash: [
    "~/Library/Application Scripts/at.buchhaltgenie.walkaitalkie",
    "~/Library/Application Support/WalkAITalkie",
    "~/Library/Caches/at.buchhaltgenie.walkaitalkie",
    "~/Library/HTTPStorages/at.buchhaltgenie.walkaitalkie",
    "~/Library/HTTPStorages/at.buchhaltgenie.walkaitalkie.binarycookies",
    "~/Library/Logs/WalkAITalkie",
    "~/Library/Preferences/at.buchhaltgenie.walkaitalkie.plist",
  ]
end
