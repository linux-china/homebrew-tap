class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.4.27"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.27/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "bee0153b1f8dfe68bbbee63eb961fb1ceae32867af1004d4d7ccf4894c6f71a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.27/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "843d5941e86cc31e10e1dc8c2941b5b6e4ab7a16a934de5e869349bfcd23e04a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.27/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eef903e9888eaff1aca87d575e1c3920671f769953f45b5f6437f295dc80d9c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.4.27/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "10e819c355a378ea3030c7833c07f294b4e5f979b0c73a12f526b1fb1adefbee"
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
