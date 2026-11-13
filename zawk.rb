class Zawk < Formula
  desc "An efficient Awk-like language implementation by Rust with stdlib"
  homepage "https://github.com/linux-china/zawk"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.7.1/zawk-aarch64-apple-darwin.tar.xz"
      sha256 "331f575e640f0543bdada8c674be640b19795d84e8dbf33d43d5681240ae8cb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.7.1/zawk-x86_64-apple-darwin.tar.xz"
      sha256 "6dcaffd71db060c3ddde61fbab46dc7ac56b20cedd5bf8c761b0ce74aee7c617"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.7.1/zawk-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "df5cd65226d6ea310770810a8d69f0f7c56f3b3bb18b0095a31809618d421f3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.7.1/zawk-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3c51a8f07a4a44f356dbce93039288c07f79ba4a5c22257b30350717fb942feb"
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
