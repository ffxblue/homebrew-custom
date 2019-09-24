class Pharod < Formula
  VERSION = "f205619f661b3b01afe1bbf1f1652c37b5e27a88"
  desc "Fork of madebymany project"
  homepage "https://github.com/ffxblue/pharod"
  url "https://github.com/ffxblue/pharod/archive/#{VERSION}.tar.gz"
  version "#{VERSION}"
  sha256 "c98f659cedbdda8a76d654c1fae5a6c4ef76a16b7de76723cb4c6a3a775ac04f"
  head "https://github.com/ffxblue/pharod.git", :branch => "master"
  depends_on "go" => :build
  depends_on "goenv" => :build
  depends_on "glide" => :build

  def install
    Dir.mktmpdir('pharod') do |tmp_dir|
      ENV['GOPATH'] = tmp_dir
      ENV['PATH'] = [File.join(tmp_dir, 'bin'), ENV['PATH']].join(':')
      pkg_dir = File.join(tmp_dir, 'src/github.com/ffxblue/pharod')
      system 'mkdir', '-p', File.dirname(pkg_dir)
      system 'ln', '-s', Dir.pwd, pkg_dir
      system "cd #{pkg_dir} && goenv install --skip-existing $(cat .go-version)"
      system "cd #{pkg_dir} && glide install"
      system "cd #{pkg_dir} && go build -ldflags -s"
      system "cd #{pkg_dir}/pharodctl && go build -ldflags -s"
      bin.install "pharod"
      bin.install "pharodctl/pharodctl"
      bin.install "pharod-start"
      bin.install "pharod-stop"
    end
  end
end
