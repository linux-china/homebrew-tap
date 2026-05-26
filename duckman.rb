class Duckman < Formula
  desc "duckman - a DuckDB version manager and toolchain CLI"
  homepage "https://github.com/linux-china/duckman"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.4/duckman-aarch64-apple-darwin.tar.xz"
      sha256 "82eb72ef4e35fc1a91d1cdfcb148a9be166ae0b0e087f1c3dc2445fd3270e844"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.4/duckman-x86_64-apple-darwin.tar.xz"
      sha256 "5f910ab42e6f4d991769c5b81b35f27373ad163293ae2c6d2dc937775a8791e7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.4/duckman-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e18d3bf1d45cbfabbcf9561ade87394b21f649a9b1ba92ce51133a09edd2947"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.4/duckman-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dbb8121fcaaaff0084867bcdcb74e4237daf661ac637aca7181dce8a69b45070"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
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
