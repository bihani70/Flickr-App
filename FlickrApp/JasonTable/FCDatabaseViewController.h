//
//  FCDatabaseViewController.h
//  FlickrAPP
//
//  Created by Ravi Bihani on 05/12/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCDatabaseViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addTextButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonCheckBlank;


@property (weak, nonatomic) IBOutlet UIImageView *ImageBackground;
-(void) handleBackgroundTap: (UITapGestureRecognizer*) sender;

@end
