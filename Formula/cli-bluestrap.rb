class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-0.68.1.tar.gz'
  sha256 '42f6afa5a00a42f6b53e02801cb09086d0d1b2c4e4c092d36baf2c17154de5cd'
  version '0.68.1'

  # General
  depends_on 'awscli'
  depends_on 'git'
  depends_on 'jq'
  depends_on 'hostess'
  depends_on 'ffxblue/custom/docker-credential-ecr-login'

  # Backend
  depends_on 'go'
  depends_on 'goenv'
  depends_on 'glide'
  depends_on 'openssl'    # api-auth
  depends_on 'libxmlsec1' # api-auth
  depends_on 'protobuf'   # gRPC API servers/clients

  # Frontend
  depends_on 'node'
  depends_on 'nodenv'
  depends_on 'yarn'
  depends_on 'watchman'

  def install
    # Use 'docker' instead of '/usr/local/bin/docker'
    ENV.prepend_path "PATH", "/usr/local/bin"
    # For ecr-helper
    ENV["AWS_SDK_LOAD_CONFIG"] = "true"
    # For symlinking from user home into homebrew 'superenv'
    localuser = ENV["USER"]

    # Install casks (can't use 'depends_on' yet)
    system "brew cask install bitbar"
    system "brew cask install docker"
    system "brew cask install kitematic"

    # Check Docker is good to go
    system "bin/check"

    # Get cli-bluestrap image
    ln_s "/Users/#{localuser}/.aws", "#{buildpath}/.brew_home/.aws"
    ln_s "/Users/#{localuser}/.docker", "#{buildpath}/.brew_home/.docker"
    # Debugging
    # system "/bin/cat", "#{buildpath}/.brew_home/.aws/credentials"
    # system "/bin/cat", "#{buildpath}/.brew_home/.aws/config"
    # system "/bin/cat", "#{buildpath}/.brew_home/.docker/config.json"
    # system "/bin/bash", "-c", "/usr/local/bin/docker-credential-ecr-login list"
    system "docker", "pull", "175914186171.dkr.ecr.ap-southeast-2.amazonaws.com/tools/cli-bluestrap:#{version}"

    # Install Bitbar plugin
    share.install Dir["bin/bitbar-*"]

    # Switch version and install bs
    inreplace "bs-wrapper", ":latest", ":#{version}"
    mv "bs-wrapper", "bs"
    bin.install "bs"
  end

  test do
    system 'bs', '--help'
  end
end
