class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.3'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.3/zawk-0.5.3-x86_64-apple-darwin.tar'
      sha256 'aeaa86a8711faf5aba9e7c5c81464dac6f73ab28d1d5f9730932ea3047454e03'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.3/zawk-0.5.3-aarch64-apple-darwin.tar'
      sha256 'ed1d78d6d1e2c950a8c140d8f22ed1066893f88f3da684b844fea13334f4fa51'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
