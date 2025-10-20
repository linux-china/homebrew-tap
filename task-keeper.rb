class TaskKeeper < Formula
  desc "Task keeper to manage tasks from different task runners"
  homepage "https://github.com/linux-china/task-keeper"
  version "0.30.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.7/task-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "032b6b103a986b4456ea75afdadd5e2e7c6f3159d42f17fd26ca78a21cd51ca7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.7/task-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "70b03b6b1408c2f90cad6e2ab959460b11cac342a876bbcb239fce7cd7c48c26"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.7/task-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a1350c5c170a3a6bfe710e78cdf3e4f9627181ff0dff0a818ebe82e8680a7f16"
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
