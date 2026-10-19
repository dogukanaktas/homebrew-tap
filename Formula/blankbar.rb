class Blankbar < Formula
  desc "Turn the MacBook Pro Touch Bar off and keep it off"
  homepage "https://github.com/dogukanaktas/blankbar"
  url "https://github.com/dogukanaktas/blankbar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c274ccad6b5230cb1f646b9e11dcd142d6463020581642775124536e7e41fc0f"
  license "MIT"

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
