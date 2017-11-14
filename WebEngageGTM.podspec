Pod::Spec.new do |s|

  s.name         = "WebEngageGTM"
  s.version      = "1.1.0"
  s.summary      = "WebEngage Implementation of GTM Tags"

  s.description  = <<-DESC
  Implements Tags for Google Tag Manager to pass events and user attributes to WebEngage using Firebase APIs.
                   DESC

  s.homepage     = "http://webengage.com"
  s.social_media_url = "http://twitter.com/webengage"

  s.platform     = :ios, "8.0"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Arpit Agrawal" => "arpit@webklipper.com" }
  s.source       = { :git => "https://github.com/WebEngage/WebEngageGTM.git", :tag => "#{s.version}" }

  s.subspec 'Xcode8' do |xc8|
    xc8.dependency 'GoogleTagManager', '~> 6.0'
    xc8.dependency 'WebEngage/Xcode8', '~> 4.0'
    xc8.source_files  = "WebEngageGTM/**/*"
  end

  s.subspec 'Xcode9' do |xc9|
    xc9.dependency 'GoogleTagManager', '~> 6.0'
    xc9.dependency 'WebEngage/Xcode9', '~> 4.0'
    xc9.source_files  = "WebEngageGTM/**/*"
  end

  s.default_subspec = 'Xcode9'

end
