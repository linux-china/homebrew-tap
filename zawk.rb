class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.12'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.12/zawk-0.5.12-x86_64-apple-darwin.tar'
      sha256 'd8785b9c4f9f08d7b10cc65e09f2eba15503e8f8ffb61c9b1e73ebc59e92b520'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.12/zawk-0.5.12-aarch64-apple-darwin.tar'
      sha256 '50617c51cd702ac189b22c222e3831d5b283a48c7bfa74db91e02ede914d2785'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
