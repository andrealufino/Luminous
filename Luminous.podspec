#
# Be sure to run `pod lib lint Luminous.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Luminous'
  s.version          = '2.2.0'
  s.summary          = 'Everything you need to know about your system.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library allows to have a lot of system information in a very fast way.
                       DESC

  s.homepage         = 'https://github.com/andrealufino/Luminous'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrea Mario Lufino' => 'andrea@andrealufino.com' }
  s.source           = { :git => 'https://github.com/andrealufino/Luminous.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.source_files = 'Sources/Luminous/*.swift'
  s.swift_version = ["5.0"]
  
  # s.resource_bundles = {
  #   'Luminous' => ['Luminous/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'SystemConfiguration', 'CoreTelephony', 'AVFoundation', 'ExternalAccessory'
  s.dependency 'Deviice', '>= 2.0.0'
end
