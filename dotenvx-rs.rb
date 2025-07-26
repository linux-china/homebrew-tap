class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.2/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "8ab2d56090b55c9dd75853eb880eb9ec4fa4276257c1ca26355fc7069238220d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.2/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "9af241f505337daff8d718741dbf3e95aa5acfb1a78fdedb16db00b170c86820"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.2/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "055256bf884fc76fe0efc79c07a5fba663f9d35b5ffbd93cd65605551bb8ae00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.2.2/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a2ced41f89f6dd9309e49bafe28912ed786917ab510078e679e506d80df3380"
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
