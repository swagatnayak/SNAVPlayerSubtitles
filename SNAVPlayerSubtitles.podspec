#
# Be sure to run `pod lib lint SNAVPlayerSubtitles.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SNAVPlayerSubtitles'
  s.version          = '1.0.3'
  s.swift_versions   = '4.2'
  s.summary          = 'Easy way to add Subtitle to AVPlayer'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'This library allows you to add .srt or .vtt Subtitles file into your AVPlyer in a easy way'
                       DESC

  s.homepage         = 'https://github.com/swagatnayak/SNAVPlayerSubtitles'
  s.screenshots     = 'https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/Screenshot1.png?raw=true', 'https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/Screenshot2.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'swagatnayak' => 'swagat.nyk@gmail.com' }
  s.source           = { :git => 'https://github.com/swagatnayak/SNAVPlayerSubtitles.git', :branch => 'master', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.social_media_url = 'https://www.linkedin.com/in/swagat-nayak-21097a141'
  s.ios.deployment_target = '10.0'

  s.source_files = 'SNAVPlayerSubtitles/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'SNAVPlayerSubtitles' => ['SNAVPlayerSubtitles/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'UIKit', 'AVKit'
end
