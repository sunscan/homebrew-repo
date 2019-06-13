cask 'burp-suite-pro' do
  version '2.0.24beta'
  sha256 '3b05d7b4b281adbe7d50d3ba67beeef46ba6b338c0dfdda866e7c59146b8d725'

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
