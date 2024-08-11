class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.11'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.11/zawk-0.5.11-x86_64-apple-darwin.tar'
      sha256 'd159805fc6f83f75a8dcedcf51fd7f40d6de9d4ed8c21a12e8cab9504c85b52c'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.11/zawk-0.5.11-aarch64-apple-darwin.tar'
      sha256 '70160b83205ec3cb7d63da3f97407a5e2b6755746e3dd7661b1486c811ddb510'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
