class Licensefinder < Formula
  desc "Find licenses for your project's dependencies"
  homepage "https://github.com/pivotal/LicenseFinder"
  url "https://github.com/pivotal/LicenseFinder.git",
      tag:      "v7.1.0",
      revision: "81092404aeaf1cb39dbf2551f50f007ed049c26c"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6373ac73507be45b2ede57c97b64112215345c4be09872504ccaa6d35e615098"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "64d7159ca202de5e3b51a6ab6833ca7e87219a899ef5bfa908f530aba8fb2af7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e2053ded4e0ceda44a1d43f3dd29d57c6f7c118abeab2ee1c561a415666b960e"
    sha256 cellar: :any_skip_relocation, ventura:        "43ba70c51eef7936f72e2de8cc7c0ae985a7415cec9781e6a32a668dc86ca2d2"
    sha256 cellar: :any_skip_relocation, monterey:       "369e2affccf92dfb4d1869d1abc23118094553f062b78c1470635fb2347bda41"
    sha256 cellar: :any_skip_relocation, big_sur:        "4944b6336d9316648a52b2a1a21a7f11cebcde1b746fc772f25d39d9672e2af3"
    sha256 cellar: :any_skip_relocation, catalina:       "4944b6336d9316648a52b2a1a21a7f11cebcde1b746fc772f25d39d9672e2af3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8fad2104fa2186844235e5628d8afe03f34b08e7b9c62631399dde2b3947b493"
  end

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "license_finder.gemspec"
    system "gem", "install", "license_finder-#{version}.gem"
    bin.install libexec/"bin/license_finder"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    gem_home = testpath/"gem_home"
    ENV["GEM_HOME"] = gem_home
    # GEM_PATH is empty on linux, so set it to find the installed gems
    ENV["GEM_PATH"] = libexec if OS.linux?
    system "gem", "install", "bundler"

    mkdir "test"
    (testpath/"test/Gemfile").write <<~EOS
      source 'https://rubygems.org'
      gem 'license_finder', '#{version}'
    EOS
    cd "test" do
      ENV.prepend_path "PATH", gem_home/"bin"
      system "bundle", "install"
      ENV.prepend_path "GEM_PATH", gem_home
      assert_match "license_finder, #{version}, MIT",
                   shell_output(bin/"license_finder", 1)
    end
  end
end
