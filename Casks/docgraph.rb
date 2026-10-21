cask "docgraph" do
  version "0.1.0"

  on_macos do
    on_arm do
      sha256 "1c9a0781682f2bdf96ac672048db6b290f7550f167def5436ea7b235b61724ee"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_darwin_arm64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "4c65f4d8aec4f309a31dcb59cec8d2941defaef6df55395411f5d3183751843a"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "ec6673851b44ded9aa6dd02641a97f9547a582e1799edd7c9a6c484a19438cb6"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_linux_amd64.tar.gz"
    end
  end

  name "docgraph"
  desc "Local hybrid documentation search for AI coding agents (MCP server)"
  homepage "https://github.com/skromesch/docgraph"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64 if OS.mac?

  binary "docgraph"

  # unsigned binary: drop the quarantine attribute so Gatekeeper lets it run
  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "docgraph"], chdir: ".",
                            writable_paths: ["docgraph"], must_succeed: false
    end
  end

  zap trash: "~/.cache/docgraph"

  caveats <<~EOS
    Download the embedding model and ONNX Runtime once (~600 MB):
      docgraph model pull
    Then run `docgraph` in your project for the setup menu.
  EOS
end
