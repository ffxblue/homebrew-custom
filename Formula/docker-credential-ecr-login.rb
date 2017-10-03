require 'formula'
require 'tmpdir'

class DockerCredentialEcrLogin < Formula
  VERSION = '19c5038b3c1fc63328b4eb99c507c72f12a27f66'

  homepage 'https://github.com/awslabs/amazon-ecr-credential-helper'
  url "https://github.com/awslabs/amazon-ecr-credential-helper/archive/#{VERSION}.tar.gz"
  sha256 '7de4e7663d7e9b884e69aff2b934a23a5411642a9e6a4322c6db0791e6061b60'
  version VERSION
  head 'https://github.com/awslabs/amazon-ecr-credential-helper.git', :branch => 'master'
  depends_on 'go' => :build

  def install
    Dir.mktmpdir('docker-credential-ecr-login') do |tmp_dir|
      ENV['GOPATH'] = tmp_dir
      ENV['PATH'] = [File.join(tmp_dir, 'bin'), ENV['PATH']].join(':')
      pkg_dir = File.join(tmp_dir, 'src/github.com/awslabs/amazon-ecr-credential-helper')

      system 'mkdir', '-p', File.dirname(pkg_dir)
      system 'ln', '-s', Dir.pwd, pkg_dir
      system "cd #{pkg_dir} && make"
      bin.install 'bin/local/docker-credential-ecr-login'
    end
  end

  def caveats
    <<-EOS.undent
      Set the contents of your ~/.docker/config.json file to be:

      {
          "credsStore": "ecr-login"
      }

    EOS
  end
end
