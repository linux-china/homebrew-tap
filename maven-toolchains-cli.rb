class MavenToolchainsCli < Formula
  desc "CLI for Apache Maven toolchains.xml"
  homepage "https://github.com/linux-china/maven-toolchains-cli"
  version "0.1.0"
  url "https://github.com/linux-china/maven-toolchains-cli/releases/download/0.1.0/mt-0.1.0-mac-x64.tar"
  sha256 "ac90a384e8fbc9c455ce6ebdd3e034e7a0c272b67fcb0a4ed0c7df95d92b35e9"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/mt"
  end

  test do
    system "#{bin}/program/mt"
  end
end
