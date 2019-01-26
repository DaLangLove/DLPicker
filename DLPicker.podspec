#
#  Be sure to run `pod spec lint DLPicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s| 
  s.name         = "DLPicker"
  s.version      = "0.0.3"
  s.summary      = "自定义各种Picker。"
  s.homepage     = "https://github.com/DaLangLove/DLPicker"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Dalang" => "magicianDL@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/DaLangLove/DLPicker.git", :tag => "#{s.version}" }
  s.source_files = "DLPicker/**/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true
end
