cask "jot" do
  version "1.0"
  sha256 "a2e907738f78700adadaec5013b85af891d301865c69a203176414f4ab089856"

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

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Jot.app"],
                   sudo: false
  end

  zap trash: "~/Library/Preferences/com.skromesch.jot.plist"
end
