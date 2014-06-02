//
//  JTSearchViewController.m
//  JasonTable
//
//  Created by Ravi Bihani on 01/12/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "JTSearchViewController.h"
#import "FCViewController.h"
#import <sqlite3.h>

@interface JTSearchViewController ()

@end

@implementation JTSearchViewController



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
    
    self.ImageBackground.image= [UIImage imageNamed:@"squaw_flat_iphone.png"];
    [self.view sendSubviewToBack:self.ImageBackground];

    
    //handle background touch
    UITapGestureRecognizer* tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:tapRecognizer];
    [self.textContent becomeFirstResponder];
    self.textContent.delegate = self;
    self.buttonImplement.hidden=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.buttonSearch sendActionsForControlEvents:UIControlEventTouchUpInside];
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        [[segue destinationViewController] setReceiveUrl:self.sendUrl];
        [[segue destinationViewController] setButtonDetailAdd:@"YES"];
        [[segue destinationViewController] setGetTitleofPage:self.textContent.text];
    }
}

//Method to validate if text box is empty or not.
- (IBAction)showSearch:(id)sender {
    
    if([self.textContent.text isEqualToString:@""])
    {
        UIAlertView *emptyText=[[UIAlertView alloc]initWithTitle:@"Error" message:@"No Text Entered" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [emptyText show];
    }
    else
    {
        NSString *part1=@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4c1fa4212b6f2cccc4cadcca4759c97c&tags=";
        NSString *part2;
        NSString *part3;
        NSString *part4;
        part2=[[NSString alloc]initWithFormat:@"%@",self.textContent.text];
        part2=[part2 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        part3=@"&text=";
        part4=[[NSString alloc]initWithFormat:@"%@",self.textContent.text];
        part4=[part4 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *part5=@"&sort=relevance&accuracy=3&extras=owner_name%2Cdate_upload%2C+date_taken%2Cgeo%2Cdescription%2Ctags%2Cmachine_tags&format=json&nojsoncallback=1";
        
        self.sendUrl=[[NSString alloc]initWithFormat:@"%@%@%@%@%@",part1,part2,part3,part4,part5];
        
        [self.buttonImplement sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}


//handling background touch and remove keyboard
-(void) handleBackgroundTap:(UITapGestureRecognizer*) sender
{
    [self.textContent resignFirstResponder];
}


@end
