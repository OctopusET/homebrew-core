require "language/node"

class CubejsCli < Formula
  desc "Cube.js command-line interface"
  homepage "https://cube.dev/"
  url "https://registry.npmjs.org/cubejs-cli/-/cubejs-cli-0.30.61.tgz"
  sha256 "1a02b94b4165dc5172afedd8e0c3818afb2e00e994ca3cd114fa36380c2605c6"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "18d5de7cfade58c78d51c79bbb25861b840e4c94f2bba8a91c0273f29c34796f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "18d5de7cfade58c78d51c79bbb25861b840e4c94f2bba8a91c0273f29c34796f"
    sha256 cellar: :any_skip_relocation, monterey:       "f7fc191cbd09bf9ab964d9be820f925771fba0087acde229bcb2c4630ce1f560"
    sha256 cellar: :any_skip_relocation, big_sur:        "f7fc191cbd09bf9ab964d9be820f925771fba0087acde229bcb2c4630ce1f560"
    sha256 cellar: :any_skip_relocation, catalina:       "f7fc191cbd09bf9ab964d9be820f925771fba0087acde229bcb2c4630ce1f560"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "18d5de7cfade58c78d51c79bbb25861b840e4c94f2bba8a91c0273f29c34796f"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cubejs --version")
    system "cubejs", "create", "hello-world", "-d", "postgres"
    assert_predicate testpath/"hello-world/schema/Orders.js", :exist?
  end
end
