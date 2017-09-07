# Uncomment the next line to define a global platform for your project
platform :ios, '10.3'

def rx_swift
    pod 'RxSwift', '~> 3.0'
end

def rx_cocoa
    pod 'RxCocoa', '~> 3.0'
end

def swinject
    pod 'Swinject'
end

def test_pods
    pod 'RxTest', '~> 3.0'
    pod 'RxBlocking', '~> 3.0'
    pod 'Nimble'
end


target 'HypeTinkoff' do
  use_frameworks!
  rx_cocoa
  rx_swift
  swinject
  pod 'Then'
  
  target 'HypeTinkoffTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'Services' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  swinject
  pod 'Cadmium'
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'
  
  target 'ServicesTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'View' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  rx_cocoa
  swinject

  target 'ViewTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'ViewModel' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    rx_swift
    rx_cocoa
    swinject
    
    target 'ViewModelTests' do
        inherit! :search_paths
        test_pods
    end
    
end

target 'Model' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  swinject
  
  target 'ModelTests' do
    inherit! :search_paths
    test_pods
  end

end
