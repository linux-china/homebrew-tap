class TaskKeeper < Formula
  desc "Task keeper to manage tasks from different task runners"
  homepage "https://github.com/linux-china/task-keeper"
  version "0.24.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.24.2/task-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "c137ed255504b97af0beb94933b4a612122cb0c83bcc3a1267de9d09629c1ecf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.24.2/task-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "6db81566a2b2db92516f6bfc2e1a8eb1cc9305bb0162fb553c7d7d6f9a5da390"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.24.2/task-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "097cac6c75dfc0e3ca2a84f7542eec9c4b5f910af6819eed6dd7ab69b7060e34"
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
      bin.install "tk"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tk"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tk"
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
