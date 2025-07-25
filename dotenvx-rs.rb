class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.1/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "e819a3196a65ae198c47df2e76fa5cac33fca3fc429d5a465044fc88e1c57e05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.1/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "ccf110e6f067a4630e489ce6cb5ad6fba8536fa9dfbd363ff4dd0a0360fd0201"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.1/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8bf5846050a33fed887479b7e320d2a12158b5c4b044f2f0b201e9e7b35248a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.1/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "abe24e31d65068d08c031a95c9b63145c821113f35e39ba3b36b51609e1a3930"
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
