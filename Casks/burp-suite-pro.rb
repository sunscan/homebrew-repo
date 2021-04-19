cask 'burp-suite-pro' do
  version '2021.3.3'
  sha256 '2721a77e147df0102397458fc70465a1a368826e04c7e34f2dbc14f44367bf27'

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
