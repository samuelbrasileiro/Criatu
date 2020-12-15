# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'Criatu' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Criatu
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Firebase/Messaging'
  
  target 'CriatuTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CriatuUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end