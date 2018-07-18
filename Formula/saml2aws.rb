require 'formula'

class Saml2aws < Formula
  homepage 'https://github.com/pavelnikolov/saml2aws'
  url 'https://github.com/pavelnikolov/saml2aws/releases/download/v2.6.2/saml2aws_2.6.2_darwin_amd64.tar.gz'
  version '2.6.2'
  sha256 'b4ac4b1bad7b83adc7158626d3564631edfb26023ef72f2a300f7c75ea39684c'

  depends_on :arch => :x86_64

  def install
    bin.install 'saml2aws'
  end

  test do
    system "#{bin}/saml2aws"
  end
end
