cask "burp-suite-pro" do
  version "2021.8.2"
  sha256 "ec81be04b431d8c5a55d7c4f7a6b15ce6ccf9d8c5ded1bc2fef970449a71fba5"

  url "https://portswigger.net/burp/releases/download?product=pro&version=#{version}&type=MacOsx"
  appcast "http://releases.portswigger.net/"
  name "Burp Suite Professional"
  homepage "https://portswigger.net/burp/"

  installer script: {
    executable: "Burp Suite Professional Installer.app/Contents/MacOS/JavaApplicationStub",
    args:       ["-q"],
    sudo:       true,
  }

  preflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{staged_path}/Burp Suite Professional Installer.app"],
                   sudo: true
  end

  uninstall delete: "/Applications/Burp Suite Professional.app"

  zap trash: "~/.BurpSuite"
end
