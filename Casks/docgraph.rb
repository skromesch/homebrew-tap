cask "docgraph" do
  version "0.2.0"

  on_macos do
    on_arm do
      sha256 "edb26be9d2b33189c9b2c3e565bb48b275d5eb98a3dee64c22f1b6eca2ff8438"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_darwin_arm64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "45b6386b12bbeeb77269354eb804b0e4a87dd03f7cdc0ce68986e032a6bb8133"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "f742bb2286a723003c17121b3b65f64f227ec24164d7c6ed377cad94ad52cfc7"
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
