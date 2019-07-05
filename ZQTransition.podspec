#
#  Be sure to run `pod spec lint ZQTransition.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "ZQTransition"
 

  s.version      = "1.0.0"
 

  s.summary      = "提供各种转场动画效果的组件"


  s.description  = <<-DESC
  提供各种转场动画效果的组件
                   DESC


  s.homepage     = "https://github.com/caozhiqiang1002"


  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "caozhiqiang1002" => "1053524532@qq.com" }


  s.source       = { :git => "https://github.com/caozhiqiang1002/ZQTransition.git", :tag => "#{s.version}" }


  s.source_files  = "Core/*.{h, m}"


  s.requires_arc = true


  s.ios.deployment_target = '8.0'

end
