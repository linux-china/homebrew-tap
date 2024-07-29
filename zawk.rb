class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.10'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.10/zawk-0.5.10-x86_64-apple-darwin.tar'
      sha256 'd5c8987c373adb8c876405f93325f1b72d3600b9cd19bb43d74f8ef2b0fc78cd'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.10/zawk-0.5.10-aarch64-apple-darwin.tar'
      sha256 'b08a1a417d07d99f7c63da2e9d6719bd7c79ce1ca0976736d51da7e5dd5fcac1'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
