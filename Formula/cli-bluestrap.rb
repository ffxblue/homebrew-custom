class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-testing.tar.gz'
  sha256 '5119253e56f66d5481c9babf501e0df1026c72d7d881e9457fba250640cbd0ba'
  version 'testing'
  depends_on 'jq'
  def existing_version
    if any_version_installed?
      # Unsure why, but 'installed_version' goes with the version defined above, not the currently installed version
      # I get the feeling thats because this is a _function_ not a variable definition...
      `#{HOMEBREW_PREFIX}/bin/brew info cli-bluestrap --json | #{HOMEBREW_PREFIX}/bin/jq -r '.[].installed[0].version'`.strip
    else
      version
    end
  end
  def existing_path
    "#{HOMEBREW_PREFIX}/Cellar/cli-bluestrap/#{existing_version}"
  end
  def compare_files(file)
    if compare_file("#{prefix}/#{file}", "#{existing_path}/#{file}")
      @@changed["#{file}"] = false
    else
      @@changed["#{file}"] = true
    end
  end
  def install
    bin.install "bin/bs"
    bash_completion.install "etc/bash_completion.d/bs"
    include.install Dir["include/*"]
    prefix.install ".bluestrap"
    prefix.install "Brewfile"
    prefix.install "config.json"
  end
  def post_install
    @@changed = Hash.new
    compare_files(".bluestrap")
    compare_files("Brewfile")
    compare_files("config.json")
    puts `bs upgrade-check '#{@@changed.to_json}'`
  end
  test do
    system 'bs', 'help'
  end
end
