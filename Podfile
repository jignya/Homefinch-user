# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'HomeFinch-CustomerApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'Alamofire'
pod 'Kingfisher', '~> 4.0'
pod 'ImShExtensions'
pod 'Hue'
pod 'TBEmptyDataSet'
pod 'SwiftyJSON', '~> 4.0'
pod 'SnapKit', '~> 4.0.0'
pod "KeyboardObserver", '~>2.1.0'
pod 'FBSDKLoginKit'
pod 'SwiftDate', '~> 5.0'
pod 'Branch'
pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'Firebase/Crashlytics'
pod 'Firebase/Analytics'


pod 'SkyFloatingLabelTextField'
pod 'PullUpController'
pod "BSImagePicker", "~> 3.1"
pod "SwiftyCam"
pod 'FSCalendar'
pod 'ReadMoreTextView'
#pod 'GooglePlaces'
#pod 'GoogleMaps'
#pod 'GoogleSignIn'

pod 'TagCellLayout'

#pod 'TwilioVoice'
pod 'PayTabsSDK', '~> 6.1.0'
pod 'TagListView', '~> 1.0'

pod 'Amplitude-iOS', '~> 4.10'

  # Pods for HomeFinch-CustomerApp

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            # Needed for building for simulator on M1 Macs
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end
