cask "jot" do
  version "1.1"
  sha256 "59bf469b46ee2b05f888d27ba063ce147c4ac94e036713f2488df020044fbd47"

  url "https://github.com/skromesch/jot/releases/download/v#{version}/Jot-#{version}.zip"
  name "Jot"
  desc "Menubar app for quick rich-text notes"
  homepage "https://github.com/skromesch/jot"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "jot.app", target: "Jot.app"

  zap trash: "~/Library/Preferences/com.skromesch.jot.plist"
end
