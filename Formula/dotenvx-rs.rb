class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.1/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "09e142ed435a65b7691b6c5571bcb42bd06ad59d59b3e018f966f0c92a1cfd50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.1/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "cdcf0c536c168ebe7e7f708a17e2c49442f68e72e9f057381b9b1c3aa71ded39"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.1/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f453b2322cd4fd08a78e89d851e36fe3c33b50968c9173e2ce428a99a843783a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.1/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "03fa624bdf70fd97e12c304f3cb1e245aeee0cea86d203b15936261dfbef6ad4"
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
      bin.install "dotenvx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dotenvx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dotenvx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dotenvx"
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
