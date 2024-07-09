class Zawk < Formula
    desc 'zawk - An efficient awk-like language by Rust with stdlib support'
    homepage 'https://github.com/linux-china/zawk'
    version '0.5.9'
    license 'Apache-2.0'

    if OS.mac? && Hardware::CPU.intel?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.9/zawk-0.5.9-x86_64-apple-darwin.tar'
      sha256 '5a318425b5377ce0172a0085132006a911248740a6b0e81a5eb37d83baf6366d'
    end
    if OS.mac? && Hardware::CPU.arm?
      url 'https://github.com/linux-china/zawk/releases/download/v0.5.9/zawk-0.5.9-aarch64-apple-darwin.tar'
      sha256 '561d197946c2b6b8152e324ae81de8ec739464ad308dc9476603dba8c819c43e'
    end

    def install
      libexec.install Dir['*']
      bin.install_symlink "#{libexec}/bin/zawk"
    end

  end
