class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.13'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.13/zawk-0.5.13-x86_64-apple-darwin.tar'
      sha256 '51872a2bc5c9e094c856abab62bc62e71c1c2828c1d3cd0c26b2a3631d607a55'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.13/zawk-0.5.13-aarch64-apple-darwin.tar'
      sha256 'e7c9c8be24612b77d70a092dd06f2984ca6fb0a6b2c32fb2e1afc2f405706124'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
