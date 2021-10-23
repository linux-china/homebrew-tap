class MavenToolchainsCli < Formula
  desc "CLI for Apache Maven toolchains.xml"
  homepage "https://github.com/linux-china/maven-toolchains-cli"
  version "0.4.0"
  url "https://github.com/linux-china/maven-toolchains-cli/releases/download/0.4.0/mt-0.4.0-mac-x64.tar"
  sha256 "ae36d01cfeada9c50bbf774cd342ae1e043e94795593002fc89c42803114558f"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/mt"
  end

  test do
    system "#{bin}/program/mt"
  end
end
