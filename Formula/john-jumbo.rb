class JohnJumbo < Formula
  desc "Enhanced version of john, a UNIX password cracker"
  homepage "https://www.openwall.com/john/"
  url "https://www.openwall.com/john/k/john-1.9.0-jumbo-1.tar.xz"
  version "1.9.0"
  sha256 "f5d123f82983c53d8cc598e174394b074be7a77756f5fb5ed8515918c81e7f3b"

  bottle do
    rebuild 6
    sha256 cellar: :any, mojave:      "18a76d1f8abe542239444a3931d1d08f5f745cbb9a202b1d5fd2e1290b30fa4d"
    sha256 cellar: :any, high_sierra: "6612d2001d80361ec70a19a8c54254a76fe1919a9cc72918032304e714144530"
    sha256 cellar: :any, sierra:      "6a2460e120f697e09a1ed62a948e5ecd767fc1b24a3f331aa4d59833205e48a4"
    sha256 cellar: :any, el_capitan:  "a87bf02d882413393f3f3759ab0fa6a171438609d101c7c9bc7772fe69e2ab47"
    sha256 cellar: :any, yosemite:    "cf9c82f416a4eb3aad7d4202b21105988d346be8d8df262ea4ca18e683475d32"
    sha256 cellar: :any, mavericks:   "b36f66b0469b5c6cde95f780671db5b32e4e4dd7c16c4e7e591043bfdef2b65c"
  end

  depends_on "pkg-config" => :build
  depends_on "gmp"
  depends_on "openssl"

  conflicts_with "john", because: "both install the same binaries"

  def install
    ENV.append "CFLAGS", "-DJOHN_SYSTEMWIDE=1"
    ENV.append "CFLAGS", "-DJOHN_SYSTEMWIDE_EXEC='\"#{share}/john\"'"
    ENV.append "CFLAGS", "-DJOHN_SYSTEMWIDE_HOME='\"#{share}/john\"'"
    cd "src" do
      system "./configure", "--disable-native-tests", "--disable-native-march"
      system "make", "clean"
      system "make", "-s", "CC=#{ENV.cc}"
    end

    doc.install Dir["doc/*"]

    # Only symlink the main binary into bin
    (share/"john").install Dir["run/*"]
    bin.install_symlink share/"john/john"

    bash_completion.install share/"john/john.bash_completion" => "john.bash"
    zsh_completion.install share/"john/john.zsh_completion" => "_john"
  end

  test do
    touch "john2.pot"
    (testpath/"test").write "dave:#{`printf secret | /usr/bin/openssl md5`}"
    assert_match(/secret/, shell_output("#{bin}/john --pot=#{testpath}/john2.pot --format=raw-md5 test"))
    assert_match(/secret/, (testpath/"john2.pot").read)
  end
end
