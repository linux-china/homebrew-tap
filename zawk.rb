class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.16'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.16/zawk-0.5.16-x86_64-apple-darwin.tar'
      sha256 '4d2ade676ea637db4f21c7feef8493c35936eb5ba527d6996fb7f0702e857aa8'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.16/zawk-0.5.16-aarch64-apple-darwin.tar'
      sha256 '856439573a8bc3d263f23bc94d1f2f0150dc1f03f8487bd42f7d07af2107ccfa'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
