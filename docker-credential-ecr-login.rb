require 'formula'
require 'tmpdir'

class DockerCredentialEcrLogin < Formula
  VERSION = 'e04cbc84e17384bc38584868fc0529e41859c207'

  homepage 'https://github.com/sentientmonkey/amazon-ecr-credential-helper'
  # url "https://github.com/sentientmonkey/amazon-ecr-credential-helper/archive/#{VERSION}.tar.gz"
  # sha256 'b7e01deb04d11a561d88a70e2c47f4aa83901daba77b5d1973744f4efc98eda5'
  version VERSION
  head 'https://github.com/sentientmonkey/amazon-ecr-credential-helper.git', :branch => 'implement-helper-list'
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
