class MavenToolchainsCli < Formula
  desc "CLI for Apache Maven toolchains.xml"
  homepage "https://github.com/linux-china/maven-toolchains-cli"
  version "0.5.0"
  url "https://github.com/linux-china/maven-toolchains-cli/releases/download/v0.5.0/mt-0.5.0-mac-x64.tar"
  sha256 "6f9f0670d84279f1362d5f14ddca82a5c4a38ef0dbae4d7265b3dde40872ffe4"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/mt"
  end

  test do
    system "#{bin}/program/mt"
  end
end
