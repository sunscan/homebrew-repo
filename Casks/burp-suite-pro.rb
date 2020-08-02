cask 'burp-suite-pro' do
  version '2020.7'
  sha256 '54a023714f6d36cd498c743c86264e1aa91503b4a68fa7c1b76a0bd408613294'

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
