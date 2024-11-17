//
//  ImagePreviewVC.m
//  Shallet
//
//  Created by HTISPL-D-4 on 07/01/17.
//  Copyright © 2017 HTISPL-D-4. All rights reserved.
//

#import "ImagePreviewVC.h"
#import "HomeCollection.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>





@interface ImagePreviewVC ()<UIViewControllerTransitioningDelegate>
{
    
    NSTimer *timer;
    NSIndexPath *currentIndexpath;
    CGFloat width;
    NSIndexPath *nextItem;
    UIPinchGestureRecognizer *tapGesture;
}

@end

@implementation ImagePreviewVC
@synthesize arrrimages;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pagecontroller.numberOfPages = arrrimages.count;
    _pagecontroller.currentPage = _index.row;
    NSLog(@"%@",arrrimages);

}

- (void)viewWillAppear:(BOOL)animated
{
    [[self.navigationController navigationBar]setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([_strcome  isEqual: @"detail"])
    {
        [[self.navigationController navigationBar]setHidden:NO];
    }
}


- (void)viewDidLayoutSubviews
{
//    if ()
//    {
//      self.collectionview.transform = CGAffineTransformMakeScale(-1, 1);
//    }
    [self.collectionview layoutIfNeeded];
    NSArray *visibleItems = [self.collectionview indexPathsForVisibleItems];
    
    if (visibleItems.count > 0)
    {
        [self.collectionview setPagingEnabled:NO];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
        nextItem = [NSIndexPath indexPathForItem:_index.item inSection:currentItem.section];
        [self.collectionview scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//        [self.collectionview reloadData];
        [self.collectionview setPagingEnabled:YES];


    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


//override var shouldAutorotate: Bool
//{
//    return true
//}
//
//override var supportedInterfaceOrientations: UIInterfaceOrientationMask
//{
//    return [.portrait, .landscapeLeft , .landscapeRight]
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Delegate & Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrrimages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Homecollection *cell = (Homecollection*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Homecollection" forIndexPath:indexPath];
    if (arrrimages.count!=0)
    {
        NSMutableDictionary *dict = [arrrimages objectAtIndex:indexPath.row];

        if ([_strcome  isEqual: @"jobdetail"] || [_strcome  isEqual: @"joblist"])
        {
            if ([dict[@"path"] rangeOfString:@"mp4"].location == NSNotFound && [dict[@"path"] rangeOfString:@"mov"].location == NSNotFound)
            {
              //image
                cell.btnPlay.hidden = YES;
                
                
                NSString *strImgURL = dict[@"path"];
                NSString *strurl = [strImgURL stringByAddingPercentEncodingWithAllowedCharacters: [NSMutableCharacterSet URLQueryAllowedCharacterSet]];
                
                [cell.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strurl]] placeholderImage:[UIImage imageNamed:@""]];

//                [cell.img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strurl]]placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
            }
            else
            {
              //video
                cell.btnPlay.hidden = NO;
                
                NSURL *videoUrl = [NSURL URLWithString: dict[@"path"]];
                AVAsset *asset = [AVAsset assetWithURL:videoUrl];
                AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                CMTime time = CMTimeMake(1, 1);
                CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];

                cell.img.image = thumbnail;

            }
        }
        else
        {
            if (dict[@"path"] != nil)
            {
                if ([dict[@"path"] rangeOfString:@"mp4"].location == NSNotFound && [dict[@"path"] rangeOfString:@"mov"].location == NSNotFound)

                {
                  //image
                    cell.btnPlay.hidden = YES;
                    
                    
                    NSString *strImgURL = dict[@"path"];
                    NSString *strurl = [strImgURL stringByAddingPercentEncodingWithAllowedCharacters: [NSMutableCharacterSet URLQueryAllowedCharacterSet]];
                    
                    [cell.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strurl]] placeholderImage:[UIImage imageNamed:@""]];

                           
//                    [cell.img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strurl]]placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
                }
                else
                {
                  //video
                    cell.btnPlay.hidden = NO;
                    
                    NSURL *videoUrl = [NSURL URLWithString: dict[@"path"]];
                    AVAsset *asset = [AVAsset assetWithURL:videoUrl];
                    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                    CMTime time = CMTimeMake(1, 1);
                    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];

                    cell.img.image = thumbnail;

                }
            }
            else if ([dict[@"videoname"] isEqualToString:@""])
            {
                cell.btnPlay.hidden = YES;
                
                NSString *strImagename = dict[@"imagename"];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
                NSString *filePath = [documentsPath stringByAppendingPathComponent:strImagename];
                cell.img.image = [UIImage imageWithContentsOfFile:filePath];
            }
            else
            {
                cell.btnPlay.hidden = NO;
                NSString *strvideoname = dict[@"videoname"];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
                NSString *filePath = [documentsPath stringByAppendingPathComponent:strvideoname];
                NSURL *videoUrl = [NSURL fileURLWithPath:filePath];
                
                AVAsset *asset = [AVAsset assetWithURL:videoUrl];
                AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                CMTime time = CMTimeMake(1, 1);
                CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];

                cell.img.image = thumbnail;
            }
        }
        
        cell.btnPlay.tag = indexPath.row;
        [cell.btnPlay addTarget:self action:@selector(btnPlayClick:) forControlEvents:UIControlEventTouchUpInside];
        

    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSMutableDictionary *dict = [arrrimages objectAtIndex:indexPath.row];
    
//    if ([dict[@"Media_Type"] intValue] == 2)
//    {
//        NSURL *url = [NSURL URLWithString:dict[@"Media_URL"]];
//        AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
//        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
//
//        controller.player = player;
//        controller.view.frame = self.view.frame;
//        [self presentViewController:controller animated:false completion:nil];
//        [player play];
//
//    }
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(Homecollection *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.scrollView.zoomScale = 1.0;
    cell.scrollView.contentSize = CGSizeMake(self.collectionview.frame.size.width, self.collectionview.frame.size.height);
    cell.img.frame = CGRectMake(0, 0, cell.scrollView.contentSize.width, cell.scrollView.contentSize.height);
    [self.collectionview reloadInputViews];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _collectionview.frame.size.width;
    _pagecontroller.currentPage = _collectionview.contentOffset.x / pageWidth;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (UICollectionViewCell *cell in [self.collectionview visibleCells])
    {
        nextItem = [self.collectionview indexPathForCell:cell];
        NSLog(@"%@",nextItem);
    }
}


-(void)btnPlayClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dict = [arrrimages objectAtIndex:btn.tag];
    
    if ([_strcome  isEqual: @"jobdetail"] || [_strcome  isEqual: @"joblist"])
    {
        NSURL *videoUrl = [NSURL URLWithString: dict[@"path"]];
        AVPlayer *player = [[AVPlayer alloc] initWithURL:videoUrl];
        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
        
        controller.player = player;
        controller.view.frame = self.view.frame;
        [self presentViewController:controller animated:false completion:nil];
        [player play];

    }
    else
    {
        NSString *strvideoname = dict[@"videoname"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:strvideoname];
        NSURL *videoUrl = [NSURL fileURLWithPath:filePath];
        
        AVPlayer *player = [[AVPlayer alloc] initWithURL:videoUrl];
        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
        
        controller.player = player;
        controller.view.frame = self.view.frame;
        [self presentViewController:controller animated:false completion:nil];
        [player play];

    }
    
}

- (IBAction)btnBackClick:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:Nil];
    
//    [self.navigationController popViewControllerAnimated:NO];
//      for (ProductDetailVC *controller in self.navigationController.viewControllers)
//      {
//          if ([controller isKindOfClass:[ProductDetailVC class]])
//          {
//              ProductDetailVC *objTmp = (ProductDetailVC *)controller;
//              objTmp.index = nextItem.row;
//              objTmp.isFromPreview = YES;
//              [self.navigationController popToViewController:controller animated:NO];
//              break;
//          }
//      }
}
@end
