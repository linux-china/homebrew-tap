class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.3'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.4/zawk-0.5.4-x86_64-apple-darwin.tar'
      sha256 '4a4b37cfc36676ca7fc13bfafb702a215041265e2e50b53457d5bff176a0e091'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.4/zawk-0.5.4-aarch64-apple-darwin.tar'
      sha256 '27cfcdcf0062505e0f92574dd15aa1fcc07151cb2a6d52cfbd4360b6889f8f51'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
