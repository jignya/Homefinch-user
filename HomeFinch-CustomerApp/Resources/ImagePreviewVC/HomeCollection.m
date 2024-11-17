//
//  Homecollection.m
//  Shallet
//
//  Created by HTISPL-D-4 on 19/12/16.
//  Copyright © 2016 HTISPL-D-4. All rights reserved.
//

#import "Homecollection.h"
#define MAXIMUM_SCALE 2.0
#define MINIMUM_SCALE 1.0
#define widthOfBlackTransVw 0
#define ZOOM_STEP 1.0

@implementation Homecollection

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.scrollView.bounces = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height) ;

//    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
//    [panRecognizer setMinimumNumberOfTouches:2];
//    [panRecognizer setMaximumNumberOfTouches:2];
//    [self.scrollView addGestureRecognizer:panRecognizer];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.img;
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

@end
