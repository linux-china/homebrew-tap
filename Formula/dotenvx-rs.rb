class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.4.18"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.18/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "2c5ab8d799f9e85535a42cf4a38ea92d86fd85177dbe2c98493a5bb9de9ca2de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.18/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "f97fa4f4cdcc10414f61feef2733c7affb916e02c87a26278b52a0e92799b523"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.18/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e22d237eec7dc84c1086514549561607dbea1dca64cea0cf1971248a745168d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.18/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a1e9929f01707bb295d555d05c563c6263dd680fff6b507fd42d60abe6190e80"
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
