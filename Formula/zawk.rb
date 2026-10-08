class Zawk < Formula
  desc "An efficient Awk-like language implementation by Rust with stdlib"
  homepage "https://github.com/linux-china/zawk"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.0/zawk-aarch64-apple-darwin.tar.xz"
      sha256 "e69345ac34aebac36db58150641c5884799b4ad809c3aeb92d890f377d6c1b26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.0/zawk-x86_64-apple-darwin.tar.xz"
      sha256 "8d8e9827d5fb9db1c0b58f3e766ff1dc55ead56426f788b8fdff1a010c77bdb9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.0/zawk-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c5ccbfff0293a4eed37281d2b2e1ea19e1aa2431c9c30f47684e4342ed765b68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/zawk/releases/download/v0.6.0/zawk-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4dcf597a16d1b47480925c6a7c3854f14af524844403d08983194bde0178083"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
