class MavenToolchainsCli < Formula
  desc "CLI for Apache Maven toolchains.xml"
  homepage "https://github.com/linux-china/maven-toolchains-cli"
  version "0.5.1"
  url "https://github.com/linux-china/maven-toolchains-cli/releases/download/v0.5.1/mt-0.5.1-mac-x64.tar"
  sha256 "7e48665043648734b332bf3de802f15053309e3ccc8d1ea773ee017eac9731bf"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/mt"
  end

  test do
    system "#{bin}/program/mt"
  end
end
