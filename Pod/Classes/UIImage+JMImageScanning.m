//
//  UIImage+JM.m
//  JMImageScanning
//
//  Created by jerome morissard on 01/08/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import "UIImage+JMImageScanning.h"

static float const JMImageScanningDefaultTreshold = 0.70f;

@implementation UIImage (JMImageScanning)

- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage treshold:(float)treshold error:(NSError **)error
{
    return [self findPositionsOfSubImage:subImage treshold:treshold breakOnFirst:NO error:error];
}

- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage treshold:(float)treshold breakOnFirst:(BOOL)breakOnFirst error:(NSError **)error
{
    CGImageRef cgimage = subImage.CGImage;
    size_t width  = CGImageGetWidth(cgimage);
    size_t height = CGImageGetHeight(cgimage);
    size_t bpr = CGImageGetBytesPerRow(cgimage);
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    
    CGImageRef bigcgimage = self.CGImage;
    size_t bigwidth  = CGImageGetWidth(bigcgimage);
    size_t bigbheight = CGImageGetHeight(bigcgimage);
    size_t bigbpr = CGImageGetBytesPerRow(bigcgimage);
    size_t bigbpp = CGImageGetBitsPerPixel(bigcgimage);
    size_t bigbpc = CGImageGetBitsPerComponent(bigcgimage);
    size_t bigbytes_per_pixel = bigbpp / bigbpc;
    
    if (bytes_per_pixel != bigbytes_per_pixel) {
        NSLog(@"Scanning impossible because bytes per pixel are diffents");
        if (error) {
            *error = [NSError errorWithDomain:JMImageScanningErrorDomain code:JMImageScanningBytePerPixelDifferentError userInfo:nil];
            return nil;
        }
    }
    
    if (width > bigwidth || height > bigbheight) {
        NSLog(@"Scanning impossible because SubImage is bigget than scanned image");
        if (error) {
            *error = [NSError errorWithDomain:JMImageScanningErrorDomain code:JMImageScanningSubImageBiggerThanScannedImageError userInfo:nil];
            return nil;
        }
    }
    
    if (self.scale != subImage.scale) {
        NSLog(@"Scanning impossible because images are not at the same scale");
        if (error) {
            *error = [NSError errorWithDomain:JMImageScanningErrorDomain code:JMImageScanningNotTheSameScaleError userInfo:nil];
            return nil;
        }
    }
    
    //Load image data
    CGDataProviderRef provider = CGImageGetDataProvider(cgimage);
    NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    const uint8_t* bytes = [data bytes];
    
    CGDataProviderRef bigProvider = CGImageGetDataProvider(bigcgimage);
    NSData* bigdData = (id)CFBridgingRelease(CGDataProviderCopyData(bigProvider));
    const uint8_t* bigBytes = [bigdData bytes];
    
    //Parcours
    size_t min = MIN(width, height);
    float r, g, b ,a ,r2 ,g2,b2, a2,pixelDiff;
    
    NSMutableArray *positions = [NSMutableArray new];
    for(size_t row = 0; row < (bigbheight - height); row++) {
        for(size_t col = 0; col < (bigwidth - width); col++) {
            float sumOffPixelSimilarities = 0.0f;
            BOOL stop = NO;
            
            //FastPath
            for(size_t subrow = 0; !stop && subrow < min -1; subrow++) {
                for(size_t subcol = subrow; !stop && subcol < min -1; subcol++) {
                    const uint8_t* pixelInBigImage = &bigBytes[(row+subrow) * bigbpr + (col+subcol) * bigbytes_per_pixel];
                    const uint8_t* pixelInSubImage = &bytes[subrow * bpr + subcol * bytes_per_pixel];
                    
                    r = pixelInBigImage[bytes_per_pixel];
                    g = pixelInBigImage[2*bytes_per_pixel];
                    b = pixelInBigImage[3*bytes_per_pixel];
                    a = pixelInBigImage[4*bytes_per_pixel];
                    
                    r2 = pixelInSubImage[bytes_per_pixel];
                    g2 = pixelInSubImage[2*bytes_per_pixel];
                    b2 = pixelInSubImage[3*bytes_per_pixel];
                    a2 = pixelInSubImage[4*bytes_per_pixel];
                    pixelDiff = 0.25 * fabs(r/255-r2/255) + fabs(g/255-g2/255) + fabs(b/255-b2/255) + fabs(a/255-a2/255);
                    if (pixelDiff > (1 - treshold)) {
                        stop = YES;
                    }
                }
            }
            
            //LargePath
            for(size_t subrow = 0; !stop && subrow < height -1; subrow++) {
                for(size_t subcol = 0; !stop && subcol < width -1; subcol++) {
                    const uint8_t* pixelInBigImage = &bigBytes[(row+subrow) * bigbpr + (col+subcol) * bigbytes_per_pixel];
                    const uint8_t* pixelInSubImage = &bytes[subrow * bpr + subcol * bytes_per_pixel];
                    
                    r = pixelInBigImage[bytes_per_pixel];
                    g = pixelInBigImage[2*bytes_per_pixel];
                    b = pixelInBigImage[3*bytes_per_pixel];
                    a = pixelInBigImage[4*bytes_per_pixel];
                    
                    r2 = pixelInSubImage[bytes_per_pixel];
                    g2 = pixelInSubImage[2*bytes_per_pixel];
                    b2 = pixelInSubImage[3*bytes_per_pixel];
                    a2 = pixelInSubImage[4*bytes_per_pixel];
                    pixelDiff = 0.25 * fabs(r/255-r2/255) + fabs(g/255-g2/255) + fabs(b/255-b2/255) + fabs(a/255-a2/255);
                    if (pixelDiff > (1 - treshold)) {
                        stop = YES;
                    }
                    sumOffPixelSimilarities = sumOffPixelSimilarities + (1 - pixelDiff);
                }
            }
            
            if (sumOffPixelSimilarities > (height * width)*treshold) {
                [positions addObject:[NSValue valueWithCGPoint:CGPointMake(col, row)]];
                if (breakOnFirst) {
                    return positions;
                }
            }
        }
    }
    
    return positions;
}

- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage treshold:(float)treshold
{
    return [self findPositionsOfSubImage:subImage treshold:treshold error:NULL];
}

- (NSArray *)findPositionsOfSubImage:(UIImage *)subImage
{
    return [self findPositionsOfSubImage:subImage treshold:JMImageScanningDefaultTreshold];
}

- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage treshold:(float)treshold error:(NSError **)error
{
    NSValue *value = [self findPositionsOfSubImage:subImage treshold:treshold breakOnFirst:YES error:error].firstObject;
    return [value CGPointValue];
}

- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage treshold:(float)treshold
{
    return [self findFirstPositionOfSubImage:subImage treshold:treshold error:NULL];
}

- (CGPoint)findFirstPositionOfSubImage:(UIImage *)subImage
{
    return [self findFirstPositionOfSubImage:subImage treshold:JMImageScanningDefaultTreshold];
}

@end
