# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

inhibit_all_warnings!

target 'Agave' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Agave
  pod 'FirebaseUI/Auth', :inhibit_warnings => true
  pod 'Firebase/Firestore', :inhibit_warnings => true
  pod 'Firebase/Core', :inhibit_warnings => true
  pod 'FacebookCore', :inhibit_warnings => true
  pod 'FacebookLogin', :inhibit_warnings => true
  
  target 'AgaveTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AgaveUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
