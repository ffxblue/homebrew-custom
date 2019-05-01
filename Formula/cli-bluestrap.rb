class CliBluestrap < Formula
  desc 'cli-bluestrap'
  homepage 'https://bitbucket.org/ffxblue/cli-bluestrap'
  url 'https://s3-ap-southeast-2.amazonaws.com/cli-bluestrap.ffxblue.com.au/cli-bluestrap-testing.tar.gz'
  sha256 '6f1a208a402829c51825d25bc4aa185cf1000c479fa2a1dffd6edc3139620aab'
  version 'testing'
  depends_on 'jq'
  def set_existing_version
    if any_version_installed?
      `#{HOMEBREW_PREFIX}/bin/brew info cli-bluestrap --json | #{HOMEBREW_PREFIX}/bin/jq -r '.[].installed[0].version'`.strip
    else
      version
    end
  end
  def get_existing_version
    @existing_version ||= set_existing_version
  end
  def existing_path
    "#{HOMEBREW_PREFIX}/Cellar/cli-bluestrap/#{get_existing_version}"
  end
  def compare_files(file)
    if compare_file("#{prefix}/#{file}", "#{existing_path}/#{file}")
      @changed["#{file}"] = false
    else
      @changed["#{file}"] = true
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
    @changed = Hash.new
    compare_files(".bluestrap")
    compare_files("Brewfile")
    compare_files("config.json")
    puts `bs upgrade-check '#{@changed.to_json}'`
  end
  test do
    system 'bs', 'help'
  end
end
