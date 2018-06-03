#
# Be sure to run `pod lib lint SEWUserDefaults.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SEWUserDefaults'
  s.version          = '0.1.0'
  s.summary          = 'UserDefaults implemented using FMDB.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/sierwan/SEWUserDefaults'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'YanWei' => '1276739318@qq.com' }
  s.source           = { :git => 'https://github.com/sierwan/SEWUserDefaults.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://www.jianshu.com/u/a4c71218bb33'

  s.ios.deployment_target = '7.0'

  s.source_files = 'SEWUserDefaults/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/SEWUserDefaults.h'
  s.frameworks = 'Foundation'
  s.dependency 'FMDB'
end
