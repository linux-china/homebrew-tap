class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.5'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.5/zawk-0.5.5-x86_64-apple-darwin.tar'
      sha256 '2af9a44830c7782565b194876ff239da90f2a93e60f0eeb8d77dbb9213d88868'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.5/zawk-0.5.5-aarch64-apple-darwin.tar'
      sha256 '3e67ba30e31375b4b7868136e157e766aba9a0503871818b69d9e9667c7cf4f2'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
