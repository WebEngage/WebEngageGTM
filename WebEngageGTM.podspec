Pod::Spec.new do |s|

  s.name         = "WebEngageGTM"
  s.version      = "2.0.0"
  s.summary      = "WebEngage Framework to interface with GoogleTagManager"

  s.description  = <<-DESC
  Implements Tags for Google Tag Manager to pass events and user attributes to WebEngage using Firebase APIs.
                   DESC

  s.platform     = :ios, "8.0"

  s.homepage     = "http://webengage.com"
  s.social_media_url = "http://twitter.com/webengage"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "WebEngage" => "support@webengage.com" }
  s.source       = { :git => "https://github.com/WebEngage/WebEngageGTM.git", :tag => "#{s.version}" }

  s.static_framework = true

  s.subspec 'Xcode10' do |xc10|
    xc10.dependency 'GoogleTagManager'
    xc10.dependency 'WebEngage/Xcode10'
    xc10.source_files = "WebEngageGTM/**/*"
  end

  s.default_subspec = 'Xcode10'

end
