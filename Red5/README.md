# react-native-red5

## Getting started

1. `$ npm install react-native-red5 --save` or `$ yarn add react-native-red5`

## Installation

1. run `$ react-native link`

#### iOS

1. Open up `node_modules/react-native-red5/ios`
1. Drop the contents of `red5` directory, not the directory itself, into root of project in Xcode
1. Do not `create copies if needed`, this is so it will read directly from the `node_modules` and receive updates
1. You will be prompted to create a bridging header, do it.
1. Add the following line: `#import <React/RCTViewManager.h>`
1. Add the following libraries to `Linked Frameworks and Libraries` under `General` in your project's target
```
CoreFoundation
OpenAL
QuartzCore

libz
libstdc++
libiconv
```

1. Add `$(PROJECT_DIR)/R5Streaming` and `$(SRCROOT)` to `Framework Search Paths` under `Build Settings`
1. Add `Enable Bitcode` to `No` under `Build Settings`
1. All set!

#### Android

1. Automatic

## Usage
```javascript
import BroadcastView from 'react-native-red5';
```
