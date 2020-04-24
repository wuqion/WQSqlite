#
# Be sure to run `pod lib lint WQSqlite.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WQSqlite'
  s.version          = '0.1.0'
  s.summary          = '第一版'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "简单的只有基本操作"

  s.homepage         = 'https://github.com/wuqion/WQSqlite'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wuqiongaia@163.com' => 'wuqiongaia@163.com' }
  s.source           = { :git => 'https://github.com/wuqion/WQSqlite.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
if ENV['IS_SOURCE']
    s.source_files = 'WQSqlite/Classes/**/*'
else
    s.source_files = 'WQSqlite/Classes/**/*.h'
    s.vendored_frameworks = 'WQSqlite/Products/*'
end
  
  # s.resource_bundles = {
  #   'WQSqlite' => ['WQSqlite/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
