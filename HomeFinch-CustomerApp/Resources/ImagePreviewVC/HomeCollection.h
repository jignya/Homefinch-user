//
//  Homecollection.h
//  Shallet
//
//  Created by HTISPL-D-4 on 19/12/16.
//  Copyright © 2016 HTISPL-D-4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Homecollection : UICollectionViewCell<UIScrollViewDelegate>

@property(nonatomic,retain)IBOutlet UIImageView *img;
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center;

@end
