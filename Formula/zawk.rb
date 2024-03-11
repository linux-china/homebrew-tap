class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.0'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.0/zawk-0.5.0-x86_64-apple-darwin.tar'
      sha256 'e0043249bcb77b390315a2b6b729b673884cf4c038573c9924f23c40fdc89af7'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.0/zawk-0.5.0-aarch64-apple-darwin.tar'
      sha256 '78626c2881a2fe3920a7666367350c82fb62a738ec08c29ef745b41b62435b81'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
