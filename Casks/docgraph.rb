cask "docgraph" do
  version "0.4.0"

  on_macos do
    on_arm do
      sha256 "da57580dce293645aba2ef464ab0bd34f9a699cbd1e0cfd3bfaa0cc7b88a72f9"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_darwin_arm64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "95f482c162a862e84172f226b731d7698b41a701d545d0368eafd1c40ae5a74c"
      url "https://github.com/skromesch/docgraph/releases/download/v#{version}/docgraph_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "b69a930977946aedf65e7948b252f0873da607d537ae684425d0d8168d38512e"
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
