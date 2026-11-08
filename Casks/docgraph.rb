cask "docgraph" do
  version "0.3.0"

  on_macos do
    on_arm do
      sha256 "fd82e7c4e0e0b43a0c628081dc622dc1fb689ba3b33237dbd588af4ec814245e"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_darwin_arm64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "11c859bef4b5e44f5120f53d375de893938848520fc4a8923c2470be0086f880"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "1e029061191db30e83ee458964941b4a4c200c25c96ea9c7e23fdef87bfb4150"
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
