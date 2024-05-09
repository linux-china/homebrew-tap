class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.7'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.7/zawk-0.5.7-x86_64-apple-darwin.tar'
      sha256 '01853d222432df72e9072553c407ad98c9dccd5d84d2b5ae81750a664afa490d'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.7/zawk-0.5.7-aarch64-apple-darwin.tar'
      sha256 'ece1f18aa88c97feb8e598d96f69fd18d035983902673c72c25232f6ca8d73bd'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
