class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-testing.tar.gz'
  sha256 '1a482a9b0189a541cf2bb35e0c833bfab7f64752002990058cb9799fafadba76'
  version 'testing'
  depends_on 'jq'
  def install
    bin.install "bin/bs"
    bash_completion.install "etc/bash_completion.d/bs"
    include.install Dir["include/*"]
    prefix.install ".bluestrap"
    prefix.install "Brewfile"
    prefix.install "config.json"

    bin.compare_file('Brewfile', 'Brewfile')
  end
  test do
    system 'bs', 'help'
  end
end
