//
//  FCViewController.h
//  trail
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{
    NSDictionary *jsonDict;
    NSArray *photos;
    NSURL *url;
    NSURL *url3;
    NSMutableArray *photoURL;
    NSData *data;
    int i;
}
@property( nonatomic, strong ) UIActivityIndicatorView* activityIndicatorView;
@property (strong, nonatomic) IBOutlet UICollectionView *jsonTable;
@property(strong,nonatomic)NSMutableArray* arrayRow;
@property(strong,nonatomic)NSString* urlLink;
@property(strong,nonatomic)NSString* receiveUrl;
@property(strong,nonatomic)NSString *buttonDetailAdd;
@property (strong ,nonatomic) NSMutableDictionary *cachedImages;
@property (nonatomic, strong) UIImageView *splashView;
//@property(nonatomic,strong)NSArray* myData;
@property(strong,nonatomic)NSString* getTitleofPage;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonAddData;

@property (weak, nonatomic) IBOutlet UILabel *labelNoData;
@end
