Pod::Spec.new do |s|
  s.name             = 'MoneyKit'
  s.module_name      = 'MoneyKit'
  s.version          = '1.1.5'

  s.summary          = 'MoneyKit for iOS is a quick and secure way to link bank accounts from within your iOS app.'

  s.description      = <<-DESC
                      The drop-in framework handles connecting to a financial institution 
                      without passing sensitive information to your server.
                       DESC

  s.homepage         = 'https://www.moneykit.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'MoneyKit'

  s.platform         = :ios, '13.0'
  s.source           = { :git => 'https://github.com/moneykit/moneykit-ios.git', :tag => s.version }

  s.ios.frameworks   = 'Foundation', 'UIKit', 'WebKit', 'SafariServices', 'CryptoKit', 'Security', 'GameplayKit', 'SpriteKit', 'CoreTelephony', 'SystemConfiguration'
  s.ios.vendored_frameworks = 'MoneyKit.xcframework'
end
