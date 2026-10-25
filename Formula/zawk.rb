class Zawk < Formula
  desc "An efficient Awk-like language implementation by Rust with stdlib"
  homepage "https://github.com/linux-china/zawk"
  version "0.6.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.4/zawk-aarch64-apple-darwin.tar.xz"
      sha256 "ce38ed211bd6372013a591dcf78d2b82834dd8149e783a585a9f9d4753732086"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.4/zawk-x86_64-apple-darwin.tar.xz"
      sha256 "6320dc6120e6067f0bda5dcc5195ecd02d05b3751ee5b50b0dee64b7f2f14dc3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.4/zawk-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "22d6bd0214153dd2aaed54741840b11530b799175c293d689f595cf299dce6bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.4/zawk-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b94c5a198ea4ab33b17317f2e11b5291ee3910135acad83c71aaf365d97bc45c"
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
