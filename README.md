# JMImageScanning

[![CI Status](http://img.shields.io/travis/Jerome Morissard/JMImageScanning.svg?style=flat)](https://travis-ci.org/Jerome Morissard/JMImageScanning)
[![Version](https://img.shields.io/cocoapods/v/JMImageScanning.svg?style=flat)](http://cocoapods.org/pods/JMImageScanning)
[![License](https://img.shields.io/cocoapods/l/JMImageScanning.svg?style=flat)](http://cocoapods.org/pods/JMImageScanning)
[![Platform](https://img.shields.io/cocoapods/p/JMImageScanning.svg?style=flat)](http://cocoapods.org/pods/JMImageScanning)

## The idea

###I have a targeted keyboard to analyse. 

![Image](./images/free.png)

###I know all the pieces of the keyboard.

![Image](./images/free-0.png)
![Image](./images/free-1.png)
![Image](./images/free-2.png)
![Image](./images/free-3.png)
![Image](./images/free-4.png)
![Image](./images/free-5.png)
![Image](./images/free-6.png)
![Image](./images/free-7.png)
![Image](./images/free-8.png)
![Image](./images/free-9.png)

I am running pixel scanning on the targeted keyboard for each pieces.

###results 
![Image](./images/demo.png)


## Installation

JMImageScanning is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JMImageScanning"
```

```objc
UIImage *keyboardImage = [UIImage imageNamed:@"free.png"];
UIImage *image = [UIImage @"free-0.png"];
NSArray *points = [keyboardImage findPositionsOfSubImage:image];
```

## Author

Jerome Morissard, morissardj@gmail.com

## License

JMImageScanning is available under the MIT license. See the LICENSE file for more info.
