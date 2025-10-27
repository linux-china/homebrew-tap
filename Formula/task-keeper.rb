class TaskKeeper < Formula
  desc "Task keeper to manage tasks from different task runners"
  homepage "https://github.com/linux-china/task-keeper"
  version "0.30.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.8/task-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "f0d25e92626188276d58448322ed700bc10d0c13fa8a507b3f0c1595539bed7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.8/task-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "c95e5fb9773c04a81f3da337dec60c5b44f6576561542fe9ea91c12f5b653004"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.8/task-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b96221e5090ba2e70bd09b07c80c68f6bac7e41666a05e785c2e8580b553e8bc"
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
