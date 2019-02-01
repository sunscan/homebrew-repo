cask 'burp-suite-pro-beta' do
  version '2.0.15beta'
  sha256 '9000e5265c5686970d9a4273f31397137fc8ebb84d7937bfabcadf45c1c09e84'

  url "file://#{ENV['HOME']}/Downloads/burpsuite_pro_macos_v#{version.dots_to_underscores}.dmg"
  appcast 'http://releases.portswigger.net/'
  name 'Burp Suite Professional'
  homepage 'https://portswigger.net/burp/'

  installer script: {
                      executable: 'Burp Suite Professional Installer.app/Contents/MacOS/JavaApplicationStub',
                      args:       ['-q', '-overwrite', '-dir', '/Applications/Burp Suite Pro Beta/'],
                      sudo:       true,
                    }

  uninstall delete: '/Applications/Burp Suite Pro Beta/Burp Suite Professional.app'

  zap trash: '~/.BurpSuite'
end
