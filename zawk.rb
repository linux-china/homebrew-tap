class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.17'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.17/zawk-0.5.17-x86_64-apple-darwin.tar'
      sha256 '2218f3f54732e1e4180abbe829aa5bd47af396f00af4f03c9ab8e97f9bd03f95'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.17/zawk-0.5.17-aarch64-apple-darwin.tar'
      sha256 '3e64b48a1379a0fab5d28f984c78d771bd4c6c72f32b76e26941aceed9f44c83'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
