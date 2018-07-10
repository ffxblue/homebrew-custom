class Pharod < Formula
  VERSION = "1da9aa1a2d55412a7d262e6d22c032f051ac53b9"
  desc "Fork of madebymany project"
  homepage "https://github.com/ffxblue/pharod"
  url "https://github.com/ffxblue/pharod/archive/#{VERSION}.tar.gz"
  version "#{VERSION}"
  sha256 "38777071d28fa498959a41517bebc0dd0e5028f1c72a288d27dbd40a39a0663c"
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
