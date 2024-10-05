class Zawk < Formula
  desc "An efficient Awk-like language implementation by Rust with stdlib"
  homepage "https://github.com/linux-china/zawk"
  version "0.5.20"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.5.20/zawk-aarch64-apple-darwin.tar.xz"
      sha256 "f35afbcac168882594a5777e28e92e740534b3abd6ed37ee279dfb6b4a98ae57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.5.20/zawk-x86_64-apple-darwin.tar.xz"
      sha256 "b71d1f061d287e1427a5171b40b469c3b07c522515ac619774a787b25a0887f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.5.20/zawk-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b82bdfa23ab3efa8e4bc6832589b7dbc3bba7ac1931c7fc5cac7801d14e74268"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "xz"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "zawk"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zawk"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "zawk"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
