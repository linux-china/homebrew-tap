class DotenvxRs < Formula
  desc "Dotenvx is a Rust command-line/library to encrypt your .env files - limiting their attack vector while retaining their benefits"
  homepage "https://github.com/linux-china/dotenvx-rs"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.2/dotenvx-rs-aarch64-apple-darwin.tar.xz"
      sha256 "4ab58f78fee1f45fe29e0a4f7052af7dec77d75f2e086f4ef43193ced97d91f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.2/dotenvx-rs-x86_64-apple-darwin.tar.xz"
      sha256 "cd223c7e50bed796d2b8c46638d35272c1c1ebd111ef717ccf72471512bd988a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.2/dotenvx-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "89a1adee27b5c8867588dd3db2b26a45a29bd778a1cc01d20296e254844259d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/dotenvx-rs/releases/download/v0.3.2/dotenvx-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "69415b408c9444cb6196e2cf62121e0f85525bda269fb2990d212d2b7ba656f2"
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
