class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-2.12.0.tar.gz'
  sha256 '2d4901ce413ddf48c53c93520763865681dcd987a1e9dacf31d832f4ba241559'
  version '2.12.0'
  depends_on 'jq'
  def install
    bin.install "bin/bs"
    bash_completion.install "etc/bash_completion.d/bs"
    include.install Dir["include/*"]
    prefix.install ".bluestrap"
    prefix.install "Brewfile"
    prefix.install "config.json"
  end
  test do
    system 'bs', 'help'
  end
end
