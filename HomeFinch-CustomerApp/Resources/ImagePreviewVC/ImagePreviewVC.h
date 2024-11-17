//
//  ImagePreviewVC.h
//  Shallet
//
//  Created by HTISPL-D-4 on 07/01/17.
//  Copyright © 2017 HTISPL-D-4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePreviewVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionview;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) NSIndexPath *index ;
@property (strong, nonatomic) IBOutlet UIPageControl *pagecontroller;
@property (strong, nonatomic) NSMutableArray *arrrimages;
@property (strong, nonatomic) NSString *strcome;

- (IBAction)btnBackClick:(id)sender;
@end
