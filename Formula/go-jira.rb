class GoJira < Formula
  desc "go-jira - simple jira command line client in Go" if respond_to? :desc
  homepage "https://github.com/Netflix-Skunkworks/go-jira"

  # curl -L -o hoge https://github.com/Netflix-Skunkworks/go-jira/releases/download/0.0.19/jira-darwin-38 && chmod +x hoge && ./hoge -h
  url "https://github.com/Netflix-Skunkworks/go-jira/releases/download/v0.1.14/jira-darwin-10.6-amd64"

  # shasum -a 256 thefile
  sha256 "b9d975396bb6570489750a806ada87fc2a00a342cb65efe373d3d24748885bb3"

  # See https://github.com/Netflix-Skunkworks/go-jira/releases
  version "0.1.14"

  def install
    bin.install "jira-darwin-10.6-amd64" => "jira"
  end

  def caveats; <<~EOS
    You will need to specify your local jira endpoint first, typically in your homedir like:
      mkdir ~/.jira.d
      cat <<EOM >~/.jira.d/config.yml
      endpoint: https://jira.mycompany.com or https://mycompany.atlassian.net
      user: login user
      EOM
    If you are working on a "foo" project, create a configuration under your project workspace at ./.jira.d/config.yml that looks like:
      project: foo
    EOS
  end

  test do
    shell_output("eval \"$(#{bin}/anyenv init -)\" && anyenv version")
  end
end
