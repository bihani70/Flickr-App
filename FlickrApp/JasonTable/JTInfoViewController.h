//
//  JTInfoViewController.h
//  JasonTable
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTInfoViewController : UIViewController


@property(strong,nonatomic)NSString* photoTitleFinal;
@property(strong,nonatomic)NSString* photoDateTakenFinal;
@property(strong,nonatomic)NSString* photoOwnerNameFinal;
@property(strong,nonatomic)NSArray* receiveComment;
@property(weak,nonatomic)UILabel *labelComment;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelOwner;
@property (retain, nonatomic) IBOutlet UITextView *scrollViewData;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
