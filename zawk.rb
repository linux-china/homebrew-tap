class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.8'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.8/zawk-0.5.8-x86_64-apple-darwin.tar'
      sha256 '578e53a1ca4cd9bdd1359136bfb1de116c04decff92c7b20ead6d8bb94b22003'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.8/zawk-0.5.8-aarch64-apple-darwin.tar'
      sha256 '4b860863fae70a89d64e9baf27ed351df19196cff2506a48de9af69095e4b207'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
