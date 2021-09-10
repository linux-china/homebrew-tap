class MavenToolChainsCLI < Formula
  desc "CLI for Maven toolchains.xml"
  homepage 'https://github.com/linux-china/maven-toolchains-cli'
  version '0.1.0'
  url "https://github.com/linux-china/maven-toolchains-cli/releases/download/#{version}/mt-#{version}-mac-x64.tar"
  sha256 'ac90a384e8fbc9c455ce6ebdd3e034e7a0c272b67fcb0a4ed0c7df95d92b35e9'

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/mt"
  end
end