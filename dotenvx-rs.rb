class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.4.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.17/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "9541633c919443e8f4c3ded02d0b3b55c2babafcf63390c5d790e6725e56daea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.17/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "74cd26d0ebf7297184622ddb2598992bad84365fa4b7036859f0372998be9751"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.17/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "16d40772d25327a10db86cee8eef4a9b8044d3236512ed61699fc825f993a700"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.17/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89c61ce3352604956c9cef4a2d1db5963635c63a8bc1678b9d2d7277fa5d048e"
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
