class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-2.25.0.tar.gz'
  sha256 '802ce0434cf98fa445bbc704ac61fcd47407876cbecc65a78082dc45acce4e08'
  version '2.25.0'
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
