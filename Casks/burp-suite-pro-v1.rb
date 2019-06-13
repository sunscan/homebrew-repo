cask 'burp-suite-pro-v1' do
  version '1.7.37'
  sha256 '3049c1fed31aa5384f3fb8a825fba17a127ca4d336250288903330961a00808d'

  url "file://#{ENV['HOME']}/Downloads/burpsuite_pro_macos_v#{version.dots_to_underscores}.dmg"
  appcast 'http://releases.portswigger.net/'
  name 'Burp Suite Professional'
  homepage 'https://portswigger.net/burp/'

  installer script: {
                      executable: 'Burp Suite Professional Installer.app/Contents/MacOS/JavaApplicationStub',
                      args:       ['-q', '-overwrite', '-dir', '/Applications/Burp Suite Pro v1/'],
                      sudo:       true,
                    }

  uninstall delete: '/Applications/Burp Suite Pro v1/Burp Suite Professional.app'

  zap trash: '~/.BurpSuite'
end
