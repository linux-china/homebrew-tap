class MavenToolchainsCli < Formula
  desc "CLI for Apache Maven toolchains.xml"
  homepage "https://github.com/linux-china/maven-toolchains-cli"
  version "0.3.0"
  url "https://github.com/linux-china/maven-toolchains-cli/releases/download/0.3.0/mt-0.3.0-mac-x64.tar"
  sha256 "33e284a569c49d0315e0caacc7797df07e0586ccefee22ae5d05d30c7008eb44"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/mt"
  end

  test do
    system "#{bin}/program/mt"
  end
end
