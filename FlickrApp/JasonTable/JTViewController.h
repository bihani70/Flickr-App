//
//  JTViewController.h
//  JasonTable
//
//  Created by Ravi Bihani on 28/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JTViewController : UIViewController
{
    NSDictionary *jsonDict;
    NSArray *comment;
    NSURL *url;
    NSString *commentUrl;
}

@property(weak,nonatomic)NSString *loadUrl;
@property(strong,nonatomic)NSString* photoTitle;
@property(strong,nonatomic)NSString* photoDateTaken;
@property(strong,nonatomic)NSString* photoOwnerName;
@property(strong,nonatomic)NSString* photoTags;
@property(strong,nonatomic)NSString* photoComputerTags;
@property(strong,nonatomic)NSString* photoID1;
@property(strong,nonatomic)NSString* photoLatitute;
@property(strong,nonatomic)NSString* photoLongitute;
@property(strong,nonatomic)NSURL *url;
@property (weak, nonatomic) IBOutlet UIButton *buttonMap;
@property (weak, nonatomic) IBOutlet UIButton *buttonDownload;
@property (weak, nonatomic) IBOutlet UILabel *label_tag;
@property(strong,nonatomic)UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView12;
@property (weak, nonatomic) IBOutlet UIButton *buttonShare;
@property (weak, nonatomic) IBOutlet UIButton *buttonInfo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityImage;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UIButton *buttonExploreTag;
@end
