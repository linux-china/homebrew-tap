class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.0/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "78769fe06d604d78d811eca13066bbd5214f4b00f9d04487aea7dc6321308b3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.0/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "3efc935d91e65c9257e03ebb976e2473fe04a277b44d6c6727595f80664f1f38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.0/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eab21e415f089d98b17dbee4ceaed4617dbdbb97941636611e42c78ca7f2af87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.0/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "098fd32743327d12d9e6af9e4e1e46c250af046ff5760d2a6ac434567d931bb5"
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
