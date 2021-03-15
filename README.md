
<h1>
    <img src="https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/play.png?raw=true" width="300" height="300" />
</h1>

# SNAVPlayerSubtitles

[![CI Status](https://img.shields.io/travis/swagatnayak/SNAVPlayerSubtitles.svg?style=flat)](https://travis-ci.org/swagatnayak/SNAVPlayerSubtitles)
 [![Version](https://img.shields.io/cocoapods/v/SNAVPlayerSubtitles.svg?style=flat)](https://cocoapods.org/pods/SNAVPlayerSubtitles)
 [![License](https://img.shields.io/cocoapods/l/SNAVPlayerSubtitles.svg?style=flat)](https://cocoapods.org/pods/SNAVPlayerSubtitles)
 [![Platform](https://img.shields.io/cocoapods/p/SNAVPlayerSubtitles.svg?style=flat)](https://cocoapods.org/pods/SNAVPlayerSubtitles)


# Example

To run the example project, clone the repo, and run ***pod install*** from the Example directory first.

```shell
pod install
```

## Requirements

**Swift 4 and above
Xcode 11**

# Installation

**SNAVPlayerSubtitles** is available through **[CocoaPods](https://cocoapods.org/pods/SNAVPlayerSubtitles)**. To install
it, simply add the following line to your Podfile:

```ruby
pod 'SNAVPlayerSubtitles'
```

Then got to your project root folder and run

```shell
pod install
```

# Uses

> For AVPlayerController

```swift
// Declare AVPlayerViewController
var playerViewController: AVPlayerViewController = AVPlayerViewController()


//MARK: - Enter your media url here (i,e .mp4, .m3u8(Hls))
let videoURL = URL(string: "<Enter your media url here>")
let subtitleURL = URL(string: "<Enter your subtitle url here>")

// Declare AVPlayer and add to AVPlayerViewController
let player = AVPlayer(url: videoURL)
self.playerViewController.player = player

------------------------------------------------

// Now to add subtitle

//MARK: - For Remote url
self.playerViewController.addSubtitles().open(fileFromRemote: subtitleURL)

//MARK: - For local file
self.playerViewController.addSubtitles().open(fileFromLocal: "")


// Now Play media
self.playerViewController.player.play()

```


#

>For Directly use in AVPlayer


```swift
//Enter your media url here (i,e .mp4, .m3u8(Hls))
let videoURL = URL(string: "<Enter your media url here>")

//Enter your subtitle url here)
let subtitleURL = URL(string: "<Enter your subtitle url here>")

// Declare AVPlayer and add to AVPlayerViewController
let player = AVPlayer(url: videoURL)

------------------------------------------------

// Now to add subtitle

//MARK: - For Remote url
self.player.addSubtitles().open(fileFromRemote: subtitleURL)

//MARK: - For local file
self.player.addSubtitles().open(fileFromLocal: "")


// Now Play media
self.player.play()

```


# Author

<h1>
 <img src="https://avatars.githubusercontent.com/u/36082457?s=400&u=a84a6c07d1922a6edd85541b94fc5cfc0a0ac892&v=4" width="80" height="80"  />
</h1>

#### Swagat Nayak
###### swagat.nyk@gmail.com

# License

SNAVPlayerSubtitles is available under the MIT license. See the LICENSE file for more info.

# Samples

 <h1>
 <img src="https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/Screenshot1.png?raw=true" />
 </h1>

 <h1>
 <img src="https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/Screenshot2.png?raw=true"  />
 </h1>