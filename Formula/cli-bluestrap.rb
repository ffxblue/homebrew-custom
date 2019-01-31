class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-2.16.0.tar.gz'
  sha256 '4d7153ee2b7aa6ad574b4e75d9d3f96a63a28886664f253da125884aa5b86d3f'
  version '2.16.0'
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
