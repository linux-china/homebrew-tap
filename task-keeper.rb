class TaskKeeper < Formula
  desc "Task keeper to manage tasks from different task runners"
  homepage "https://github.com/linux-china/task-keeper"
  version "0.30.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.3/task-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "2326a6539d12fdf5e68b16c72a4d0d5ad3e454db2ba049b3c22947a85638ee06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.3/task-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "622a6adc77180ae12c9392ef5c4aad56d0bdc1b89c9159d6be35b1f65ed67005"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/linux-china/task-keeper/releases/download/v0.30.3/task-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6f476e2387788c313ce077458777d7f530e2860d6ab08e7eb5cb6e29d7567111"
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
