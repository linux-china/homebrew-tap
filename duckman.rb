class Duckman < Formula
  desc "duckman - a DuckDB version manager and toolchain CLI"
  homepage "https://github.com/linux-china/duckman"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.6/duckman-aarch64-apple-darwin.tar.xz"
      sha256 "b50ea74c8dc25e340b8368fe31a749190b7b2c4a84f8c2ddfd55dda3520bf87f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.6/duckman-x86_64-apple-darwin.tar.xz"
      sha256 "62b81b9f9f5f346a21cf6cf7a83d301665e35f2a48c307996e738f7f5206f63e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.6/duckman-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e36284eb0620ac49648b30668f45dfbdf25a8eba719e4dcb0276a14f8544217a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/duckman/releases/download/v0.1.6/duckman-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19c0c8d4b511c228392e425a1d461ba2df7a8fbfd861489da918036aa70d6a99"
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
