Pod::Spec.new do |s|

  s.name         = "WebEngageGTM"
  s.version      = "2.0.1"
  s.summary      = "WebEngage Framework to interface with GoogleTagManager"

  s.description  = <<-DESC
  Implements Tags for Google Tag Manager to pass events and user attributes to WebEngage using Firebase APIs.
                   DESC

  s.platform     = :ios, "10.0"
s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}

  s.homepage     = "http://webengage.com"
  s.social_media_url = "http://twitter.com/webengage"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "WebEngage" => "support@webengage.com" }
  s.source       = { :git => "https://github.com/WebEngage/WebEngageGTM.git", :tag => "#{s.version}" }

  s.static_framework = true

  s.dependency 'GoogleTagManager'
  s.dependency 'WebEngage'
  s.source_files = "WebEngageGTM/**/*"

end
