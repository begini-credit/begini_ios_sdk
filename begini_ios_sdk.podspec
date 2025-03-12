Pod::Spec.new do |spec|

  spec.name         = "begini_ios_sdk"
  spec.version      = "1.2.3"
  spec.summary      = "Begini iOS SDK"
  spec.description  = "Begini SDK allows you to collect device data in your iPhone app."

  spec.homepage     = "https://github.com/begini-credit/begini_ios_sdk"
  spec.license      = {
                        :type => 'MIT',
                        :file => 'LICENSE'
                      }
  spec.author             = { "Begini" => "mobiledev@begini.co" }
  spec.platform     = :ios, "12.1"
  spec.source       = { :git => "https://github.com/begini-credit/begini_ios_sdk.git", :tag => spec.version.to_s }

  spec.swift_versions = "5.1"
  spec.ios.deployment_target  = "13"

  # Use XCFramework built via Carthage
  spec.vendored_frameworks = 'begini_ios_sdk.xcframework', 'Carthage/Build/iOS/AWSCore.framework', 'Carthage/Build/iOS/AWSKMS.framework'

  # Explicitly declare system frameworks required
  spec.frameworks = 'Foundation', 'UIKit', 'Security', 'SystemConfiguration'

  # Ensure static linking if necessary
  spec.static_framework = true

end
