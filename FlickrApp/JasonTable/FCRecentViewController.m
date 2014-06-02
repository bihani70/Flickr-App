//
//  FCRecentViewController.m
//  FlickrAPP
//
//  Created by Ravi Bihani on 04/12/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "FCRecentViewController.h"
#import "FCViewController.h"
@interface FCRecentViewController ()

@end

@implementation FCRecentViewController

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
    self.buttonRecent.enabled=YES;
    //self.buttonRecent.
    //[self.buttonRecent becomeFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectbutton:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSString *part1=@"http://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=4c1fa4212b6f2cccc4cadcca4759c97c&extras=owner_name%2Cdate_upload%2C+date_taken%2Cdescription%2Ctags%2Cmachine_tags%2Curl_t&format=json&nojsoncallback=1";
       
        
        
        //NSLog(@"\n%@\n",self.sendUrl);
        //NSURL *object=[[NSURL alloc]initWithString:self.urlLink];
        [[segue destinationViewController] setReceiveUrl:part1];
    }
}

@end
