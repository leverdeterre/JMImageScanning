//
//  UIImage+JMImageScanning.h
//  JMImageScanning
//
//  Created by jerome morissard on 01/08/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const JMImageScanningErrorDomain = @"JMImageScanningErrorDomain";

typedef NS_ENUM(NSUInteger, JMImageScanningError) {
    JMImageScanningBytePerPixelDifferentError,
    JMImageScanningSubImageBiggerThanScannedImageError
};

@interface UIImage (JMImageScanning)

- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage;
- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage treshold:(float)treshold;
- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage treshold:(float)treshold error:(NSError **)error;

- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage;
- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage treshold:(float)treshold;
- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage treshold:(float)treshold error:(NSError **)error;

@end
