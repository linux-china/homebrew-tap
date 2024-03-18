class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.0'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.2/zawk-0.5.2-x86_64-apple-darwin.tar'
      sha256 '0d3423eca75854d6a6afc21ac03f06ee7d0b9a5c85292a417a4cfc207126d08d'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.2/zawk-0.5.2-aarch64-apple-darwin.tar'
      sha256 '5f4c767aa3f25d160ac9267fef9a52969b2aaf0493f2c98128b3ffe4cd629a9e'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
