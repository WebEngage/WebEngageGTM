# WebEngageGTM

You can use Google Tag Manager (GTM) to send data from your website or mobile apps to WebEngage.

#### Before getting started:
1. [Integrate WebEngage iOS SDK](https://docs.webengage.com/docs/ios-getting-started)
2. Set up and configure [Google Tag Manager and Firebase](https://developers.google.com/tag-manager/ios/v5/).


#### Install WebEngage's GTM pod
Since you've integrated the WebEngage iOS SDK as per the step above, there is one change you need to make in the integration to setup the GTM dependency. Update your Podfile to remove existing WebEngage SDK and include WebEngage's GTM library as shown below.
```
target 'MyApp' do
  #remove WebEngage pod & add 'WebEngageGTM'
  #pod 'WebEngage' 
  pod 'WebEngageGTM'
end
```

Detailed WebEngageGTM Documentation Steps available [here](https://docs.webengage.com/docs/gtm).
