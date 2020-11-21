#
# Be sure to run `pod lib lint RecordARFace.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RecordARFace'
  s.version          = '0.9.5'
  s.summary          = 'It is an application to mask the face with AR.'
  s.homepage         = 'https://github.com/daisukenagata/RecordARFace'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'daisukenagata' => 'dbank0208@gmail.com' }
  s.source           = { :git => 'https://github.com/daisukenagata/RecordARFace.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dbank0208'
  s.ios.deployment_target = '14.2'
  s.swift_versions = '5.3.1'
  s.source_files = 'RecordARFace/Classes/**/*'
end
