class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-2.64.3.tar.gz'
  sha256 '357d18cd37aaf352663d651333631f4591f76df5d249b51188316bc9a96a167d'
  version '2.64.3'
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
