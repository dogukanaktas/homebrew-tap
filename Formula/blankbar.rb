class Blankbar < Formula
  desc "Turn the MacBook Pro Touch Bar off and keep it off"
  homepage "https://github.com/dogukanaktas/blankbar"
  url "https://github.com/dogukanaktas/blankbar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c274ccad6b5230cb1f646b9e11dcd142d6463020581642775124536e7e41fc0f"
  license "MIT"

  bottle do
    root_url "https://github.com/dogukanaktas/homebrew-tap/releases/download/blankbar-1.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "58e068a3b99ab98d6396f3c0e4173954c876b32184e8e7e49f0b459c1b7c7e52"
    sha256 cellar: :any_skip_relocation, sequoia:      "77ac66a63b42fb48ba47d78c713af51b914cc38cbdd76598dd0f640bedff80ed"
  end

  depends_on :macos
  uses_from_macos "swift" => :build

  deny_network_access!

  def install
    system "swift", "build", *std_swift_args
    bin.install ".build/release/blankbar"
  end

  def caveats
    <<~EOS
      To turn the Touch Bar off and keep it off after sleep and login:
        blankbar install

      Before `brew uninstall blankbar`, remove the background agent:
        blankbar uninstall
    EOS
  end

  test do
    assert_equal "blankbar #{version}", shell_output("#{bin}/blankbar --version").strip
    assert_match "Usage: blankbar", shell_output("#{bin}/blankbar help")
    shell_output("#{bin}/blankbar bogus 2>&1", 64)
  end
end
