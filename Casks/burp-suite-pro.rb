cask 'burp-suite-pro' do
  version '2021.3.1'
  sha256 'a1ae0266f8b053862363be37e603828d7e5d349fd9886bf2d8850ce514728def'

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
