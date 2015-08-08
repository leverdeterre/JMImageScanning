//
//  JMViewController.m
//  JMImageScanning
//
//  Created by Jerome Morissard on 08/01/2015.
//  Copyright (c) 2015 Jerome Morissard. All rights reserved.
//

#import "JMViewController.h"
#include <sys/time.h>

@import JMImageScanning;
@interface JMViewController ()
@property (strong) UIImageView *scannedResultImageView;
@end

@implementation JMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIImage *bigImage = [UIImage imageNamed:@"free.png"];
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:bigImage];
    
    CGRect topImageViewFrame = topImageView.frame;
    topImageViewFrame.origin.x = 0.5 * (CGRectGetWidth(self.view.frame) - CGRectGetWidth(topImageViewFrame));
    topImageViewFrame.origin.y = 20.0f;
    topImageView.frame = topImageViewFrame;
    [self.view addSubview:topImageView];
    
    self.scannedResultImageView = [[UIImageView alloc] initWithFrame:topImageView.frame];
    CGRect bottomImageViewFrame = self.scannedResultImageView.frame;
    bottomImageViewFrame.origin.x = 0.5 * (CGRectGetWidth(self.view.frame) - CGRectGetWidth(topImageViewFrame));
    bottomImageViewFrame.origin.y = CGRectGetMaxY(topImageView.frame) + 20.0f;
    self.scannedResultImageView.frame = bottomImageViewFrame;
    [self.view addSubview:self.scannedResultImageView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *images = @[@"free-0.png",
                            @"free-1.png",
                            @"free-2.png",
                            @"free-3.png",
                            @"free-4.png",
                            @"free-5.png",
                            @"free-6.png",
                            @"free-7.png",
                            @"free-8.png",
                            @"free-9.png"];
        
        struct timeval time;
        gettimeofday(&time, NULL);
        long startMillis = (time.tv_sec * 1000) + (time.tv_usec / 1000);
        
        for (NSString *imageName in images) {
            UIImage *image = [UIImage imageNamed:imageName];
            
            NSError *error;
            CGPoint p = [bigImage findFirstPositionOfSubImage:image treshold:0.70f error:&error];
            NSLog(@"%@ %@",imageName, NSStringFromCGPoint(p));
            
//#warning For demo effect on simulator :)
//            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *subImageView = [[UIImageView alloc] initWithImage:image];
                CGRect subImageViewFrame = subImageView.frame;
                subImageViewFrame.origin.x = p.x;
                subImageViewFrame.origin.y = p.y;
                subImageView.frame = subImageViewFrame;
                [self.scannedResultImageView addSubview:subImageView];
            });

      
        }
        
        gettimeofday(&time, NULL);
        long endMillis = (time.tv_sec * 1000) + (time.tv_usec / 1000);
        NSLog(@"end in %ld ms", endMillis - startMillis);
    });
}

@end
