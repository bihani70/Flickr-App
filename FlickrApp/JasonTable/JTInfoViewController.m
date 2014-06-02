//
//  JTInfoViewController.m
//  JasonTable
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "JTInfoViewController.h"

@interface JTInfoViewController ()


@end

@implementation JTInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squaw_flat_iphone.png"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    self.labelTitle.text=self.photoTitleFinal;
    self.labelDate.text=self.photoDateTakenFinal;
    self.labelOwner.text=self.photoOwnerNameFinal;
    [self showComment];
}

-(void) showComment
{

    
    NSString *resultStr = @"";
    if([self.receiveComment count]==0 )
    {
     self.scrollViewData.text=@"NO Comments";
    }
    else
    {
        for (id bookmark in self.receiveComment)
        {
            resultStr = [NSString stringWithFormat:@"%@User :%@\nComment :%@\n\n", resultStr, [bookmark objectForKey:@"authorname"],[bookmark objectForKey:@"_content"]];
        }
        NSString *new12=[[NSString alloc]initWithFormat:@"%@",resultStr];
        self.scrollViewData.text = new12;
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
