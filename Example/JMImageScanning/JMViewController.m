//
//  JMViewController.m
//  JMImageScanning
//
//  Created by Jerome Morissard on 08/01/2015.
//  Copyright (c) 2015 Jerome Morissard. All rights reserved.
//

#import "JMViewController.h"

@import JMImageScanning;
@interface JMViewController ()

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
    
    UIImageView *scannedResultImageView = [[UIImageView alloc] initWithFrame:topImageView.frame];
    CGRect bottomImageViewFrame = scannedResultImageView.frame;
    bottomImageViewFrame.origin.x = 0.5 * (CGRectGetWidth(self.view.frame) - CGRectGetWidth(topImageViewFrame));
    bottomImageViewFrame.origin.y = CGRectGetMaxY(topImageView.frame) + 20.0f;
    scannedResultImageView.frame = bottomImageViewFrame;
    [self.view addSubview:scannedResultImageView];

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
    
    for (NSString *imageName in images) {
        UIImage *image = [UIImage imageNamed:imageName];
        CGPoint p = [bigImage findFirstPositionOfSubImage:image];
        NSLog(@"%@ %@",imageName, NSStringFromCGPoint(p));
        UIImageView *subImageView = [[UIImageView alloc] initWithImage:image];
        CGRect subImageViewFrame = subImageView.frame;
        subImageViewFrame.origin.x = p.x;
        subImageViewFrame.origin.y = p.y;
        subImageView.frame = subImageViewFrame;
        [scannedResultImageView addSubview:subImageView];
    }
}

@end
