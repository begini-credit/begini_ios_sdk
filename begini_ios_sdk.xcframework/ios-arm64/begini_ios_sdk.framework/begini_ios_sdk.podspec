Pod::Spec.new do |spec|

  spec.name         = "begini_ios_sdk"
  spec.version      = "1.2.2"
  spec.summary      = "Begini iOS SDK"
  spec.description  = "Begini SDK allows you to collect device data in your iPhone app."

  spec.homepage     = "https://github.com/begini-credit/begini_ios_sdk"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "Begini" => "mobiledev@begini.co" }
  spec.platform     = :ios, "12.1"
  spec.ios.deployment_target  = "12.1"

  # Define where to fetch the SDK from
  spec.source       = { :git => "git@github.com:begini-credit/begini_ios_sdk.git", :tag => spec.version.to_s }
  
  # Swift Version
  spec.swift_versions = "5.1"

  # Include AWS dependencies (Fixes linking issue)
  spec.dependency 'AWSCore', '~> 2.37.2'
  spec.dependency 'AWSKMS', '~> 2.37.2'

  # Declare XCFramework correctly
  spec.vendored_frameworks = 'begini_ios_sdk.xcframework'

  # Ensure all resources are included
  spec.resource_bundles = {
    'begini_ios_sdk' => ['Resources/**/*']
  }

end
