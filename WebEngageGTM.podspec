Pod::Spec.new do |s|

  s.name         = "WebEngageGTM"
  s.version      = "1.0.5"
  s.summary      = "WebEngage Implementation of GTM Tags"

  s.description  = <<-DESC
  Implements Tags for Google Tag Manager to pass events and user attributes to WebEngage using Firebase APIs.
                   DESC

  s.homepage     = "http://webengage.com"
  s.social_media_url = "http://twitter.com/webengage"

  s.platform     = :ios, "7.0"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Arpit Agrawal" => "arpit@webklipper.com" }
  s.source       = { :git => "https://github.com/WebEngage/WebEngageGTM.git", :tag => "#{s.version}" }


  s.source_files  = "WebEngageGTM/**/*"
  
  s.subspec 'Xcode7' do |xc7|
    xc7.dependency 'WebEngage/Xcode7', '~> 3.5.4'
    xc7.dependency 'GoogleTagManager', '~> 5.0'
  end

  s.subspec 'Xcode8' do |xc8|
    xc8.dependency 'WebEngage', '~> 3.5.4'
    xc8.dependency 'GoogleTagManager', '~> 5.0'
  end

  s.subspec 'NoWebEngage' do |o|
    o.source_files  = "WebEngageGTM/**/*"
  end

  s.default_subspec = 'Xcode8'

end
