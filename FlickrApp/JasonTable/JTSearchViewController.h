//
//  JTSearchViewController.h
//  JasonTable
//
//  Created by Ravi Bihani on 01/12/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTSearchViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textContent;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;
@property (strong, nonatomic)NSString* sendUrl;
@property (weak, nonatomic) IBOutlet UIButton *buttonImplement;
@property (weak, nonatomic) IBOutlet UIImageView *ImageBackground;

-(void) handleBackgroundTap: (UITapGestureRecognizer*) sender;

@end
