cask 'burp-suite-pro' do
  version '2.1.01'
  sha256 '18b8aa61ab15f406523973392ba9687a9a392ed196b17db91c09ffe960fac48e'

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
