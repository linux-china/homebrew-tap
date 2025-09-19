class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.4.22"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.22/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "d86172bfe3794809141110d3f372baa43fa9e8ce7e63bb76a71d21bd0a79d568"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.22/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "1557c846855ec82deb684ad14c3daf20d095f75b4a62180d52be672fd5180522"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.22/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0336deee9f588f80ea88460459118bde3c3a382c40a828a0750b26cd2ebe741f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.22/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ce423398bcffd5cf2b465aa506fe37e2d46352ebbbb40b5b4f4892e2396370f1"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
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
      bin.install "dotenvx", "mkey"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dotenvx", "mkey"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dotenvx", "mkey"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dotenvx", "mkey"
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
