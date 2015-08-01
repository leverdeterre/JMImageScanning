#
# Be sure to run `pod lib lint JMImageScanning.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JMImageScanning"
  s.version          = "0.1.0"
  s.summary          = "Basic ocr recognition to hack secure keyboards."
  s.description      = <<-DESC
                       Basic ocr recognition to hack secure keyboards
                       DESC
  s.homepage         = "https://github.com/leverdeterre/JMImageScanning"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jerome Morissard" => "morissardj@gmail.com" }
  s.source           = { :git => "https://github.com/leverdeterre/JMImageScanning.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/leverdeterre'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JMImageScanning' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
