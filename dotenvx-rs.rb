class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.4.34"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.34/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "83fddf47a2b890746d26cf3dff842abab5d1fb33d5bdcb4de4f18f50e79d27b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.34/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "81a07ec328ed9a1b0516aa50daa53bc0e0e4755b95d8e24ae94c4e9df9d83d83"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.34/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a6adf7f488f235aa214ba6c60d4a42146c35f4cecf3db751178b1f4d1c2eb178"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.34/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2b598324a2f2e5fb225e5c172d61c666472623e557977e580692b9ef71f726f8"
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
