class TaskKeeper < Formula
  desc "Task keeper to manage tasks from different task runners"
  homepage "https://github.com/linux-china/task-keeper"
  version "0.30.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.5/task-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "3153e73d293585084385beb76110ac2321136235c31e12e8191a57b85747e706"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.5/task-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "8995e3228bf9016ca28d044cdd2394eff2a08ccb8ba673afbbee9b5ce0fe89c0"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.5/task-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b5f0ffad95aa879682fab5ca4f90293350554c4ac61090a5f6c55908c6eec74"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
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
      bin.install "sq", "tk"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sq", "tk"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sq", "tk"
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
