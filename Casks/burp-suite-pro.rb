cask 'burp-suite-pro' do
  version '2.1.05'
  sha256 'f2105ec4fd4ba8ff8d8f0ee295fe87be15703244fa3304b9af7c54d7807dbc12'

  url "file://#{ENV['HOME']}/Downloads/burpsuite_pro_macos_v#{version.dots_to_underscores}.dmg"
  appcast 'http://releases.portswigger.net/'
  name 'Burp Suite Professional'
  homepage 'https://portswigger.net/burp/'

  installer script: {
                      executable: 'Burp Suite Professional Installer.app/Contents/MacOS/JavaApplicationStub',
                      args:       ['-q', '-overwrite', '-dir', '/Applications/'],
                      sudo:       true,
                    }

  uninstall delete: '/Applications/Burp Suite Professional.app'

  zap trash: '~/.BurpSuite'
end
