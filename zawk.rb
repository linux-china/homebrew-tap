class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.15'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.15/zawk-0.5.15-x86_64-apple-darwin.tar'
      sha256 '4beb19047ba176734463582e6467ee00e7ab37c481defc2a736a97e61307277a'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.15/zawk-0.5.15-aarch64-apple-darwin.tar'
      sha256 '1204148230243e516c8c57f548c674ab9fb9cba2de58e887aea83d484b5e304d'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
