## My other works

[http://leverdeterre.github.io] (http://leverdeterre.github.io)

# JMImageScanning

[![CI Status](http://img.shields.io/travis/Jerome Morissard/JMImageScanning.svg?style=flat)](https://travis-ci.org/Jerome Morissard/JMImageScanning)
[![Version](https://img.shields.io/cocoapods/v/JMImageScanning.svg?style=flat)](http://cocoapods.org/pods/JMImageScanning)
[![License](https://img.shields.io/cocoapods/l/JMImageScanning.svg?style=flat)](http://cocoapods.org/pods/JMImageScanning)
[![Platform](https://img.shields.io/cocoapods/p/JMImageScanning.svg?style=flat)](http://cocoapods.org/pods/JMImageScanning)


## What is it for ?
Scanning image to find sub image, like a CIDetector but to detect targeted images.

## Really? but what is it for ?
I'm working on a lot of Bank applications and in order to execute functional testing i fix the constraint of logging on real testing accounts (protected by secure keyboard) using this library.

The idea, i have a master image (here, a secure keyboard to analyse). 

![Image](./images/free.png)

I want to find a sub image (here, all the pieces of the keyboard).

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

## The result :)
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

NSError *error;
CGPoint p = [keyboardImage findFirstPositionOfSubImage:image treshold:0.70f error:&error];
```

## TODO
- [x] increase performance on device (V0.2 increase 42% of performance)
- [ ] support heterogeneous scales

## Performances
iPhone 5 (iOS8.4), 100 run

|  Version  | search time (ms) | 
| ------------- |:-------------:| 
|  V0.1  | 620ms | 
|  V0.2  | 359ms | 
|  develop  | 156ms | 


## Author

Jerome Morissard, morissardj@gmail.com

## License

JMImageScanning is available under the MIT license. See the LICENSE file for more info.
