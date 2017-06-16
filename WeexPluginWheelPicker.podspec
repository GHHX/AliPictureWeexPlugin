Pod::Spec.new do |s|

  s.name         = "WeexPluginWheelPicker"
  s.version      = "0.0.1"
  s.summary      = "时间选择器插件"
  s.description  = <<-DESC
  weex插件,时间选择器，picker。
  DESC
  s.homepage     = "https://github.com/GHHX/AliPictureWeexPlugin.git"
  s.license      = "MIT"
  s.author       = { "风海" => "hanxu.hx@alibaba-inc.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/GHHX/AliPictureWeexPlugin.git", :tag => "0.0.1" }
  s.source_files  = "ios/Sources/*.{h,m}"
  s.framework  = "UIKit"
  s.dependency "WeexPluginLoader"
  s.dependency "WeexSDK"
  s.requires_arc = true
end
