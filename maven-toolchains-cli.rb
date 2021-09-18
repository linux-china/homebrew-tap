class MavenToolchainsCli < Formula
  desc "CLI for Apache Maven toolchains.xml"
  homepage "https://github.com/linux-china/maven-toolchains-cli"
  version "0.2.0"
  url "https://github.com/linux-china/maven-toolchains-cli/releases/download/0.2.0/mt-0.2.0-mac-x64.tar"
  sha256 "1b4b250a5a82eee4e30223fea449be1b74d1431dca08d7a72b673ed702df8178"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/mt"
  end

  test do
    system "#{bin}/program/mt"
  end
end
