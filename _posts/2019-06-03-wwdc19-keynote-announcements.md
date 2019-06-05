---
title: What's new from WWDC19 keynote [Updated]
subtitle: Today's announcements in one page
description: Read what's has been announced at the WWDC19 keynote
category: ["Articles"]
tags: ["Apple", "iOS", "macOS", "hardware"]
---

*Update 1 (June 3): added information about features and changes announced today during the State of the Union keynote.*

*Update 2 (June 3: added links to previews on Apple's website.*

*Update 3 (June 4): PWA improvements notes.*

*Update 4 (June 5): ARKit 3 requirements*

<br/>

A (very long) list of today's announcements. The source is mainly the today keynote, otherwise sources are linked.

It will be updated as new features and hidden tricks are discovered.

### WWDC by the numbers
- over 1000 developers attending
- 97% customer satisfaction of iOS 12
- 85% iOS 12 install-base
- 100.000 radio stations in Apple Music
- 75% cars globally feature CarPlay
- macOS is #1 in customer satisfaction
- over 450,000 apps in the App Store using Swift

### Software announcements

#### tvOS 13
- multi-user support
- Xbox One S and PS4 controller support
- new underwater screensaver

#### watchOS 6
- new watchfaces, including a new one that recalls the Siri one of today. All of them supports new complications (maybe on S4 only, though)
- haptic and audio chimes trigger each new hour
- new apps: *Apple Books* for audiobooks, *Voice Memos*, *Calculator*, all of them with their complications
- *Calculator* comes with support for bill splitting and tip calculator)
- watchOS apps no longer need its companion iPhone one
- ...it gets the AppStore, search it by voice, scribble or using Siri
- ...and it is now an indipendent push notification target
- text fields for account creation and sign in directly on the Apple Watch
- Extended Runtime API, apps in these categories can run in the background even after the user lowers his wirst:
    - self-care
    - mindfulness
    - medical therapy
    - home monitoring
- Streaming Audio API to stream whatever you want
- new *Noise* app uses Apple Watch microphone to tell you if you are in a loud environment. It collects small audio sample and no data is stored.
- new *Cycle Tracking* app for women, including notification and predictions. It will also be available in *Health* app in next iOS release
- complication to get live audio from Live Games shows
- For You in Apple Music
- option to mute email notifications
- songs recognition
- automatic software updates
- new watch bands

watchOS features preview available [on Apple's website](https://www.apple.com/watchos/watchos-preview/).

#### iOS 13
- (the much awaited) dark mode
- performance and speed optimizations
- 30% faster FaceID
- to mirror changes made on the Apple Watch, the new *Health* app gets new *Summary* view. All is encrypted as it has been.
- new way to shrink apps packages:
    - up to 50% smaller deployments
    - up to 60% smaller updates
- up 2x faster app launch times
- keyboard supports swipe typing (or as they say *scribble typing*)
- redesigned share sheet layout
- time-sync'ed lyrics in *Music* app
- *Mail* gaining desktop-class editing
- all-new *Reminders* app with ability to mention people and set details by just typing, pretty much like to what Fantastical does today
- new *Maps* app
    - rebuilt maps of US, now offering a view (called *Look around*) similar to what Google Street View offers. Other countries to be available next year
- iMessages:
    - Animoji get makeup option and cartoon AirPods
    - Memoji stickers to stick memoji in messages, in a similar way to what you do. Available on A9 and later devices, True Depth camera not a requirement
- separated iCloud accounts for work and personal life
- redesigned *Reminders* app
- *Find My* app
    - merges *Find My Devices* and *Find My Friends* apps
    - find your devices offline by using other devices as mesh networks
    - encrypted and anonymous
- peek and pop, quick actions in homescreen and Control Center and other 3D-touch-specific features coming to iPhone and iPads as 'Haptic Touch' features
- much improved PWA support. Check [this thread](https://twitter.com/firt/status/1135709949772881921) for screenshots and features
- iPads got their own iOS branch, called *iPadOS*, albeit Gui Rambo [has proved](https://twitter.com/_inside/status/1135640410175332356) it's just a marketing name. It's still iOS under the hood, not a fork the way tvOS is

**Photos and Camera**

- Scan library and uses ML to automatically find duplicates
- *High‑Key Mono* camera portrait effect
- option to rotate videos
- revamped *Photos* app with new Photos tab layout. You can now move between different views, such as: Years, Months, Days and All Photos
- memories are collected by event and shown by year
- video memories autoplay

The Sweet Setup [wrote about it](https://thesweetsetup.com/a-closer-look-at-the-upcoming-photos-and-camera-apps-in-ios-13/).

**Carplay, HomePod and Siri**

- messages announcements for all apps using SiriKit, with ability to reply to messages on the fly
- audio sharing to share links of music you are listening to with friends nearby
- HomePod gets multi-users supports, in the form of recognizing user voices
- new CarPlay dashboard
- Do-Not-Disturb while driving in CarPlay
- *Shortcuts*:
    - it is now a system-app and is getting multi-step commands
    - provides suggested automations
    - conversational shortcuts
    - Automation supporting specific triggers (pretty much a `cron` with a GUI)
    - recording Siri Shortcut audio is no longer needed and phrases can be added with a tap
    - works on HomePod, too
- *Neural TTS* for all-software and much more 'natural' voice play

iOS features preview available [on Apple's website](https://www.apple.com/ios/ios-13-preview/features/).

**New privacy settings and features**

Note: many of these fetures are available on macOS, too.

- share your location just once
- Wi-Fi and Bluetooth protection to avoid being tracked via those wireless signals
- background tracking alerts
- *Sign-in with Apple*
    - sign up and login to web apps using your Apple ID, but you choose what details of your Apple account you share
    - it creates a random email addresses and emails are forwarded to the real inbox. Each app gets a different, random email address
    - Available on iOS, macOS, tvOS and the web
    - accounts are already verified and protected by [2-factor authentication](https://support.apple.com/en-us/HT204915)
- HomeKit privacy improvements
    - *HomeKit Secure Video*: your home videos are analyzed locally on your HomeKit hub device (HomePod, AppleTV or iPad) and only the analysis result is uploaded to your iCloud account and made available to apps. Them won't get the original video and it is never uploaded on to the cloud
    - HomeKit coming to routers, it actually is a firewall to stop private home-related data going out

#### iPadOS 13 exclusive features

Besides iOS improvements coming to iPhone and iPod Touch, the ones below are iPad exclusives.

- widget pinning on the homescreen
- drag to easily swap between apps opened in slide-over mode
- split-view now supporting multiple views of the same app, thus enabling multi-window
- tap and hold to preview links
- iCloud Drive now supports file and folder sharing
- Files app getting support for thumb-drives, SD cards and SMB shares. Only on USB-C equipped iPads.
- Apps such as Lightroom can import files w/o passing throught the gallery.
- Safari on iPad gets:
    - desktop-class browsing
    - download manager
    - 30 new keyboard shortcuts
- Font management
- iPhone keyboard (including scribble-typing) coming to iPad to easier typing with one hand. You can drag the keyboard wherever you want
- system-wide multi-touch improvements:
    - tap to place the cursor
    - drag the scroll indicator to scroll
    - drag the cursor with your finger to select text
    - 3-finger pinch to copy and 3-finger spread to paste
    - 3-finder swipe to undo
- Apple Pencil latency down to 9ms (from 20ms)
- *PencilKit* API
- ability to drag Apple Pencil tools panel anywhere on the screen
- dragging from the corner with the Apple Pencil takes a screenshot and opens the image annotating tools
- new *full-page* capture mode trims just the content, similar to what window-capture does today on macOS

iPadOS features preview available [on Apple's website](https://www.apple.com/ipados/ipados-preview/features/).

#### macOS 10.15 Catalina

- iTunes is finally and officially dead. New apps Podcasts, Music and TV taking place
- iOS device management being integrated in Finder sidebar. (I think it makes sense)
- TV app to support 4K HDR and Dolby Atmos
- Sidecar to turn you iPad as a secondary display, like to what Duet and Luna display do. Apple Pencil supported as input device, too
- new Accessibility features:
    - Voice Control to control the Mac entirely by voice
    - full 'voice control' coming to iOS and macOS, keywords like  *numbers* and *grid* show up numbers on the screen to enable selection of GUI areas. Audio is processed locally. Personally those are UX features you'd expect by Apple
- T2 chip providing activation lock to enabled Macs (and I am wondering how it is different from today)
- new gallery view in *Notes*
- ScreenTime
- *[DriverKit](https://developer.apple.com/documentation/driverkit)*, to move kernel extensions to userland for enhanced security. Traditional kernel extensions to be dropped in the future (no ETA given yet)
- apps need user authorization to read/write Desktop, Documents, iCloud Drive and external drives
- zsh to be the default shell ([source](https://twitter.com/krzyzanowskim/status/1135670186932080641))
- ... last but not least, the official name of 'Marzipan' is *Project Catalyst*

macOS 10.15 features preview available [on Apple's website](https://www.apple.com/macos/catalina-preview/features/).

#### Swift 5, SDK and frameworks updates

- [Swift 5](https://swift.org/blog/swift-5-released/)
    - has reached ABI and module stability
    - GitHub package registry to support Swift packages
- [Xcode 11 comes with built-in Swift Package Manager](https://twitter.com/johnsundell/status/1135629223224328193) and [lets you create a Swift package straight from the File menu](https://twitter.com/johnsundell/status/1135647878523830273)
- TestFlight getting 'Feedback' feature and users can submit screenshots, too
- RxSwift-like framework called *Combine* ([source](https://twitter.com/johnsundell/status/1135633624366223360))
- new in ARKit 3:
    - people occlusion, to render object correctly as people move among them
    - visual coherence
    - motion capture
    - more robust 3D object detection
    - multiple-face tracking
    - simultaneous front and back camera
    - Apple Pay in AR Quick Look
    - detect up to 100 images
    - faster reference image loading
    - HDR environment textures
    - auto-detect image size
    - faster image loading
    - collaborative session
    - video recording in AR Quick Look
    - audio support in AR Quick Look
    - AR coaching
    - last but not least, Minecraft coming to i*OS playable in real world thanks to ARKit. Players can even 'jump into' the game field
    - ARKit 3 will be available on devices currently supporting it, but some features will be restricted to iPhones and iPads with A12/A12X Bionic chips. Those are: people occlusion, motion capture, simultaneous front and back camera usage, and multiple face tracking. [Apple docs here](https://developer.apple.com/augmented-reality/arkit/)
    - Full coverage on ARKit 3 by 9to5mac available [here](https://9to5mac.com/2019/06/03/apple-arkit-3/)
- [RealityKit](https://developer.apple.com/documentation/realitykit), a new framework for easier integration of 3D modeling into apps
- *[Reality Composer](https://developer.apple.com/augmented-reality/reality-composer/)* app
    - a fast and easy way to create 3D models
    - WYSIWYG editor
    - Coming to iOS and macOS
- *SwiftUI*, a new declarative UI framework, featuring:
    - drag-n-drop support
    - built-in inspector
    - localization
    - right-to-left
    - dynamic type
    - spaces and insets
    - built-in animations support
    - dark-mode
    - easily switch between layouts (e.g. list and grid)
    - built-in support for integration with other frameworks by Apple
    - supports all platforms, from tvOS to watchOS
    - integrates with existing code
    - new workflow in Xcode dedicated to it
    - interactive online documentation
    - check [this thread](https://twitter.com/b3ll/status/1135757988612861952) for an 'Hello World!' and some notes about SwiftUI
- [CoreML](https://developer.apple.com/machine-learning/) new features:
    - new image saliency
    - on-device speech (similar to what Google showed at the I/O in May)
    - text recognition
    - support for 100+ ML model types
    - model personalization to let apps update models in the background using anonymized bits of user data
- [VisionKit](https://developer.apple.com/documentation/visionkit), to use the camera of iOS devices to scan documents
- [PencilKit](https://developer.apple.com/documentation/pencilkit), to easily handle drawing
- [CryptoKit](https://developer.apple.com/documentation/cryptokit), to perform common cryptographic operations
- new watchOS framework to develop native indipendent apps

*Hacking with Swift* published [a comprehensive article](https://www.hackingwithswift.com/articles/193/whats-new-in-ios-13) covering all announcements for developers.

### Hardware announcements

#### Mac Pro

- up to 28-core Intel Xeon CPU
- ECC memory and 6 DIMM slots, up to 1.5 Tb 2993 Mhz speed
- 8x internal PCI-express
- I/O card sporting:
    - 2x Thunderbolt 3 ports
    - 3.5 jack
- 2x 10Gb Ethernet ports
- custom MPX expansion module
    - fanless design
    - x16 PCI-Express module + another bus to offer even higher speed
    - supports Infinity Fabric Link
- new Afterburner graphics card
    - FPGA-equipped card capable to process 6 billion pixel per second or 8x8K streams or 12x4K streams
- 1.4 kW power supply
- all new airflow design to help it stay cool
- new case easy to open, now featuring wheels
- capable of running up to 1000 tracks in (new version of) Logic Pro
- can run up to 6x6K Apple Pro Display XDR for 120 million pixels
- rack deployment form-factor available
- baseline starts at 5999$, featuring:
    - 8-core
    - 32 GB RAM
    - 256 GB SSD
    - AMD WX7100

#### Pro Display XDR

- 32-inch LCD screen
- 6K resolution, 20 billion pixels
- XDR (eXtreme Dynamic Range)
- P3 wide-color gamut
- 10-bit colors
- Reference modes
- Superwide viewing angles
- nano-textures make the glass rough and let the surface to act as an anti-reflective coating, without lowering contrast
- 1000-nits (brightness that can be kept indefinitely)
- 1600-nits peak
- 1,000,000:1 contrast ratio, that
- stand supports portrait mode
- sold at 4999$
- VESA mount sold separately for $199
- (disappointed to see) stand sold separately for $999

All of those goodness will be available in the fall. Usually in late September for iOS, watchOS and tvOS and first half of October for macOS.

Wow! That's it for now.

Thanks for reading.
