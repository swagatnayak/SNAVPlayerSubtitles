
<h1>
    <img src="https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/play.png?raw=true" width="200" height="200" />
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

> For AVPlayerViewController

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
self.playerViewController.addSubtitles(textStyle: .CLEAR_BACKGROUND).open(fileFromRemote: subtitleURL,type: .VTT)

//MARK: - For local file
self.playerViewController.addSubtitles(textStyle: .CLEAR_BACKGROUND).open(fileFromLocal: "",type: .VTT)
/*
NOTE : 
    textStyle -> Optional (default -> .CLEAR_BACKGROUND)
    type -> Required (Must be .SRT or .VTT)
*/

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
self.player.addSubtitles(textStyle: .CLEAR_BACKGROUND).open(fileFromRemote: subtitleURL,type: .VTT)

//MARK: - For local file
self.player.addSubtitles(textStyle: .CLEAR_BACKGROUND).open(fileFromLocal: "",type: .VTT)

/*
NOTE : 
    textStyle -> Optional (default -> .CLEAR_BACKGROUND)
    type -> Required (Must be .SRT or .VTT)
*/

// Now Play media
self.player.play()

```
# Property

>Property

|Property|Remark|Accepted values|
|---|---|---|
| ``` .addSubtitles(textStyle: .CLEAR_BACKGROUND) ```|textStyle -> Optional<br/>Default value = .CLEAR_BACKGROUND|.CLEAR_BACKGROUND <br/> .BLACK_BACKGROUND|
|``` .open(fileFromRemote: URL(string: ""),type: .VTT) ```|type  ->  Required*|.VTT <br/> .SRT|


# Author

<h1>
 <img src="https://avatars.githubusercontent.com/u/36082457?s=400&u=a84a6c07d1922a6edd85541b94fc5cfc0a0ac892&v=4" width="80" height="80"  />
</h1>

#### Swagat Nayak
###### swagat.nyk@gmail.com

<h1>
<a href="https://www.linkedin.com/in/swagat-nayak-21097a141"><img src="https://img.icons8.com/fluent/50/000000/linkedin.png"/></a>
<a href="https://twitter.com/SwagatN16141870"><img src="https://img.icons8.com/fluent/48/000000/twitter.png"/></a>
<a href="https://github.com/swagatnayak"><img src="https://img.icons8.com/fluent/48/000000/github.png"/></a>
</h1>

# License

SNAVPlayerSubtitles is available under the MIT license. See the LICENSE file for more info.

# Samples

 <h1>
 <img src="https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/Screenshot1.png?raw=true" />
 </h1>

 <h1>
 <img src="https://github.com/swagatnayak/SNAVPlayerSubtitles/blob/master/RefFiles/Screenshot2.png?raw=true"  />
 </h1>
