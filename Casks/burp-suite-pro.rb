cask 'burp-suite-pro' do
  version '2020.11'
  sha256 '2ef05218ec3b4dad92d59f7859aecbec5131e073db44484e6f4f1a1a60358113'

  url "file://#{ENV['HOME']}/Downloads/burpsuite_pro_macos_v#{version.dots_to_underscores}.dmg"
  appcast 'http://releases.portswigger.net/'
  name 'Burp Suite Professional'
  homepage 'https://portswigger.net/burp/'

  preflight do
    system_command '/usr/bin/xattr',
                   args: ['-rd', 'com.apple.quarantine', "#{staged_path}/Burp Suite Professional Installer.app"],
                   sudo: true
  end

  installer script: {
                      executable: 'Burp Suite Professional Installer.app/Contents/MacOS/JavaApplicationStub',
                      args:       ['-q'],
                      sudo:       true,
                    }

  uninstall delete: '/Applications/Burp Suite Professional.app'

  zap trash: '~/.BurpSuite'
end
