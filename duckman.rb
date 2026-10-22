class Duckman < Formula
  desc "duckman - a DuckDB version manager and toolchain CLI"
  homepage "https://github.com/linux-china/duckman"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/duckman/releases/download/v0.2.0/duckman-aarch64-apple-darwin.tar.xz"
      sha256 "cb8f74f58b59f3f4ed37b1a4b77718a51c572d852923b8b8b4a8693faf34fd0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/duckman/releases/download/v0.2.0/duckman-x86_64-apple-darwin.tar.xz"
      sha256 "ee2c7546713a2521b2eb85dca4ddcc3269dc81bee8fcf81e6c002d60fb16d877"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/duckman/releases/download/v0.2.0/duckman-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bda7b35968bfcc608753d35d143edc718affd62706dc1c93b9a534243fe9fe0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/duckman/releases/download/v0.2.0/duckman-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f28d2848796cd84c8624121fbefc31575f504f0ba9b217f06dd5aa217e1d88ff"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
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
      bin.install "duckman", "duckman_shim"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "duckman", "duckman_shim"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "duckman", "duckman_shim"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "duckman", "duckman_shim"
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
