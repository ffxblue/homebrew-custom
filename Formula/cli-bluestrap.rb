class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/infrastructure-clibluestrap-development-v1/cli-bluestrap-0.25.0.tar.gz'
  sha256 '0216001ec5e3cda8d96ed5157e1f97715e55dc55988c730e4ca98c4fbfeffde9'
  version '0.25.0'

  conflicts_with "pharod", :because => "it is broken"

  def install
    ENV.prepend_path "PATH", "/usr/local/bin"
    ENV["PREFIX"] = prefix
    system 'make', 'install', 'VERSION=0.25.0'
  end

  test do
    system 'bs', '--help'
  end
end
