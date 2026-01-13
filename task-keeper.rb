class TaskKeeper < Formula
  desc "Task keeper to manage tasks from different task runners"
  homepage "https://github.com/linux-china/task-keeper"
  version "0.31.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.31.0/task-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "fe9bd0876f98a1ba594242ec0caea169cbfe738ee4b052859e1ba6ffa0f18939"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.31.0/task-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "e0f76ab9cf2d3374d7094df73dbe2d11e7d42f09d13460779d960c13195fd5a8"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.31.0/task-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cd54147b2412f873ed73fe76e3734e17903b35f4de6783603b90088dab701982"
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
