require 'formula'

class Saml2aws < Formula
  homepage 'https://github.com/pavelnikolov/saml2aws'
  url 'https://github.com/pavelnikolov/saml2aws/releases/download/v2.6.3-beta/saml2aws_2.6.2_darwin_amd64.tar.gz'
  version '2.6.3'
  sha256 '38ac337780567d42ea145b59bf483769f3b15216e066fa0bb3d8c74a3155dfcb'

  depends_on :arch => :x86_64

  def install
    bin.install 'saml2aws'
  end

  test do
    system "#{bin}/saml2aws"
  end
end
