//
//  JTViewController.m
//  JasonTable
//
//  Created by Ravi Bihani on 28/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "JTViewController.h"
#import "JTInfoViewController.h"
#import "FCMapViewController.h"
#import "FKTagViewController.h"

@interface JTViewController ()

@property (strong, nonatomic) IBOutlet UIView *mainViewWeb;
@property (weak, nonatomic) IBOutlet UIButton *buttonHide;
@end

@implementation JTViewController
{
   // NJKWebViewProgressView *_progressView;
    //NJKWebViewProgress *_progressProxy;
}
@synthesize url;

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
    self.buttonHide.hidden=YES;
    self.title = self.photoTitle;
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squaw_flat_iphone.png"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];

    
    //running things in backround to make ui responsive
    dispatch_async(dispatch_get_main_queue(),
                   ^{
    url = [NSURL URLWithString:self.loadUrl];
    self.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    self.imageView12.image = self.image;
    [self.activityImage stopAnimating];
    self.activityImage.hidden=YES;
                       
                   });
    
    //checking tag is empty or not.
    
    if([self.photoTags isEqualToString:@""])
    {
        if(![self.photoComputerTags isEqualToString:@""])
        {
            self.label_tag.text=[[NSString alloc]initWithFormat:@"%@",self.photoComputerTags];
            self.photoTags=@"Photo with No Tag Data";
            self.buttonExploreTag.hidden=YES;
        }
        else
        {
            self.photoTags=@"Photo with No Tag Data";
             self.label_tag.text=[[NSString alloc]initWithFormat:@"%@",self.photoTags];
            self.buttonExploreTag.hidden=YES;
        }
    }
    else if(![self.photoTags isEqualToString:@""])
    {
         self.label_tag.text=[[NSString alloc]initWithFormat:@"%@",self.photoTags];
    }
    
   
    
    if(([self.photoLatitute doubleValue]==0) || ([self.photoLongitute doubleValue]==0))
    {
        self.buttonMap.enabled=FALSE;
        self.buttonMap.hidden=TRUE;
        self.labelLocation.enabled=TRUE;
        self.labelLocation.hidden=FALSE;
    }
    else
    {
        self.buttonMap.enabled=TRUE;
        self.buttonMap.hidden=FALSE;
        self.labelLocation.enabled=FALSE;
        self.labelLocation.hidden=TRUE;
    }
    
    jsonDict = [[NSDictionary alloc] init];
    comment = [[NSArray alloc] init];
    
    //selecting the flickr api according to tag
    NSString *commentUrl1=@"http://api.flickr.com/services/rest/?method=flickr.photos.comments.getList&api_key=4c1fa4212b6f2cccc4cadcca4759c97c&photo_id=";
    NSString *commentUrl2=self.photoID1;
    NSString *commentUrl3=@"&format=json&nojsoncallback=1";
    
    //concatenating the string to make the api url
    commentUrl=[[NSString alloc]initWithFormat:@"%@%@%@",commentUrl1,commentUrl2,commentUrl3];
    url = [NSURL URLWithString:commentUrl];
    
    //passing url to json method
    [self parseJSONWithURL:url];
   

}



- (void) parseJSONWithURL:(NSURL *) jsonURL
{
    //
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:jsonURL completionHandler:^(NSData *data,
                                                          NSURLResponse *response, NSError *error) {
        if (error != nil){
            NSLog(@"Error = %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to Flickr. Please make sure you are connected to a network." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Back",nil];
                [alert show];
                
            });
            
        }
    }]resume];
    
    
    //running method in background to speed up the process
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Run request on background queue (thread).
    dispatch_async(queue, ^{
        NSError *error = nil;
        
        // Request the data and store in a string.
        NSString *json = [NSString stringWithContentsOfURL:jsonURL encoding:NSASCIIStringEncoding error:&error];
        if (error == nil){
            
            // Convert the String into an NSData object.
            NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
            
            // load data object using NSJSONSerialization without options.
            jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            
            // Parsing success.
            if (error == nil)
            {
                //running method in background to speed up the process
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                   comment = [[jsonDict valueForKey:@"comments"] valueForKey:@"comment"];
                                   
                               });
                
                
            }
            
            //failed, display error as alert.
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Uh Oh, Parsing Failed." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                
                [alertView show];
            }
        }
        
    });
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        exit(0);
    }
    else if(buttonIndex==1)
    {
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSArray *words = [self.photoTags componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([segue.identifier isEqualToString:@"showDetail"])
    {
        [[segue destinationViewController] setPhotoDateTakenFinal:self.photoDateTaken];
        [[segue destinationViewController] setPhotoOwnerNameFinal:self.photoOwnerName];
        [[segue destinationViewController] setPhotoTitleFinal:self.photoTitle];
        [[segue destinationViewController]setReceiveComment:comment];
    }
    else if([segue.identifier isEqualToString:@"showMap"])
    {
        [[segue destinationViewController] setReceiveMapTitle:self.photoTitle];
        [[segue destinationViewController] setReceiveLatitute:self.photoLatitute];
        [[segue destinationViewController] setReceiveLongitude:self.photoLongitute];
        
    }
    else if([segue.identifier isEqualToString:@"showTagExpand"])
    {
        [[segue destinationViewController]setRecieveTag2:words];
    }
}



- (IBAction)imageDownload:(id)sender {
    
   // NSLog(@"url recieved: %@", self.loadUrl);
   // NSLog(@"Downloading...");
    // Get an image from the URL below
    dispatch_async(dispatch_get_main_queue(),
                   ^{
  
    UIImageWriteToSavedPhotosAlbum(self.image, nil,nil,nil);
                   });
    UIAlertView *downloaded=[[UIAlertView alloc]initWithTitle:@"Image Download" message:@"Image Downloaded Successfully" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                       
    [downloaded show];
}

- (IBAction)buttonShare:(id)sender {
   
 
    [self.activityImage bringSubviewToFront:self.mainViewWeb];
    self.activityImage.hidden=NO;
    self.activityImage.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    
    [self.activityImage startAnimating];
    [self.buttonHide sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)buttonShareFinal:(id)sender
{
    
    //running method in background to speed up the process
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       NSString *message = @"Check out this Flickr Image\n\n";
                       // NSString *urlString = self.loadUrl;

                       NSArray *itemsToShare = [[NSMutableArray alloc]initWithObjects:message,self.image, nil];

                       // create a UIActivityViewController so user can choose where to share
                       UIActivityViewController *activityViewController =[[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
                       
                       // display the UIActivityViewController
                       [self presentViewController:activityViewController animated:YES completion:nil];
                       [self.activityImage stopAnimating];
                       self.activityImage.hidden=YES;
                     
                   });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
