post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
               end
          end
   end
end
# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'TriviaGPT' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for June20Proj
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Analytics'
  pod 'Firebase/Storage'
  pod 'Firebase/Database'
  pod 'GoogleSignIn', '~> 5.0'
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'Eureka'
  pod 'DropDown'
  pod 'SCLAlertView'
  pod 'CardSlider'
  pod 'TransitionButton'
  pod 'NVActivityIndicatorView'
  pod 'SkeletonView'
  pod 'ChatGPTSwift', '~> 1.3.1'
  

end
