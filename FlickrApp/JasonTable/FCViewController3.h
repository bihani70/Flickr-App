//
//  FCViewController3.h
//  FlickrAPP
//
//  Created by Mr Ravi Bihani on 17/12/2013.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCViewController3 : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{
    NSDictionary *jsonDict;
    NSArray *photos;
    NSURL *url;
    NSURL *url3;
    NSMutableArray *photoURL;
    NSData *data;
    NSURLConnection *connectionInProgress;
}
@property( nonatomic, strong ) UIActivityIndicatorView* activityIndicatorView;
@property (nonatomic, strong) NSArray *entries;
@property(nonatomic,strong)NSMutableData *dataPhoto;
@property (strong, nonatomic) IBOutlet UICollectionView *jsonTable;
@property(strong,nonatomic)NSMutableArray* arrayRow;
@property(strong,nonatomic)NSString* urlLink;
@property(strong,nonatomic)NSString* receiveUrl;
@property (strong ,nonatomic) NSMutableDictionary *cachedImages;
@property (nonatomic, strong) UIImageView *splashView;

@end
