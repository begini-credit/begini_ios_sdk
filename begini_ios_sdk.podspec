Pod::Spec.new do |spec|

  spec.name         = "begini_ios_sdk"
  spec.version      = "1.2.1"
  spec.summary      = "Begini iOS SDK"
  spec.description  = "Begini SDK allows you to collect device data in your iPhone app."

  spec.homepage     = "https://github.com/begini-credit/begini_ios_sdk"
  spec.license      = {
                        :type => 'MIT',
                        :file => 'LICENSE'
                        }
  spec.author             = { "Begini" => "mobiledev@begini.co" }
  spec.platform     = :ios, "12.1"
  spec.source = { :git => "https://github.com/begini-credit/begini_ios_sdk.git", :tag => spec.version.to_s }

  spec.swift_versions = "5.1"
  spec.ios.deployment_target  = "13"
  spec.vendored_frameworks = 'begini_ios_sdk.xcframework'

  # Third-party dependencies
  spec.dependency 'AWSCore'
  spec.dependency 'AWSKMS'

end
