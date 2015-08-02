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
    JMImageScanningSubImageBiggerThanScannedImageError,
    JMImageScanningNotTheSameScaleError
};

@interface UIImage (JMImageScanning)

/**
 *  This method return all the finded points (encoded as NSValue)
 *
 *  @param subImage image you want to find
 *  @param treshold 0.0f-1.0f value, pourcentage of similarity to consider a match
 *  @param error    an error
 *
 *  @return Array of NSValue points
 */
- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage treshold:(float)treshold error:(NSError **)error;

/**
 *  This method return all the finded points (encoded as NSValue)
 *
 *  @param subImage image you want to find
 *  @param treshold 0.0f-1.0f value, pourcentage of similarity to consider a match
 *
 *  @return Array of NSValue points
 */
- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage treshold:(float)treshold;

/**
 *  This method return all the finded points (encoded as NSValue)
 *  A default treshold value is used.
 *
 *  @param subImage image you want to find
 *
 *  @return Array of NSValue points
 */
- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage;

/**
 *  This method return the first match
 *
 *  @param subImage image you want to find
 *  @param treshold 0.0f-1.0f value, pourcentage of similarity to consider a match
 *  @param error    an error
 *
 *  @return a CGPoint
 */
- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage treshold:(float)treshold error:(NSError **)error;

/**
 *  This method return the first match
 *
 *  @param subImage image you want to find
 *  @param treshold 0.0f-1.0f value, pourcentage of similarity to consider a match
 *
 *  @return a CGPoint
 */
- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage treshold:(float)treshold;

/**
 *  This method return the first match
 *  A default treshold value is used.
 *
 *  @param subImage image you want to find
 *
 *  @return a CGPoint
 */
- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage;

@end
