class Zawk < Formula
  desc "An efficient Awk-like language implementation by Rust with stdlib"
  homepage "https://github.com/linux-china/zawk"
  version "0.6.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.9/zawk-aarch64-apple-darwin.tar.xz"
      sha256 "d85e16fe1d13af633797b8495e740f235ae6461add7ca24ac3cf877b07356289"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.9/zawk-x86_64-apple-darwin.tar.xz"
      sha256 "01b321bcb3620a5d545012851d055303263dc6706a6ca5cfa5745477fd103daf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.9/zawk-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "be1417844797ef7d5f98c74d428827c9d29d1090bdaa551ab90e85224c995ca9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.9/zawk-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9fd80da18041b8def2af7a1428d14cd202b8d44f059f3fb19677baae39154e58"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
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
      bin.install "zawk"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zawk"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "zawk"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "zawk"
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
