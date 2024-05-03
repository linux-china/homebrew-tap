class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.6'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.6/zawk-0.5.6-x86_64-apple-darwin.tar'
      sha256 'ae5ee8ac0cbb37092ab944de692fd99689ba5f02b35b45f7896ac227923c5dcb'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.6/zawk-0.5.6-aarch64-apple-darwin.tar'
      sha256 '8cc967e59bfcc8758b4c353aa1fd279dee8aaea5db94a7a142e18cde36c812a1'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
