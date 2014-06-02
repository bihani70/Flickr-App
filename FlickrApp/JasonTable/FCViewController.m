//
//  FCViewController.m
//  FK
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Ravi Bihani. All rights reserved.
//

#import "FCViewController.h"
#import "FC.h"
#import "JTViewController.h"
#import "LazyLoad.h"
#import <sqlite3.h>

@interface FCViewController ()
{
    NSURL *url12;
    
}

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *myDatabase;
@property (strong, nonatomic) NSString *statusOfAddingToDB;
@property(assign,nonatomic)BOOL ascending;
@property(strong,nonatomic)UIRefreshControl *refreshControl;

@end

@implementation FCViewController

@synthesize databasePath;
@synthesize myDatabase;
@synthesize statusOfAddingToDB,ascending,refreshControl;

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    self.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"squaw_flat_iphone.png"]];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
     self.activityIndicatorView.color=[UIColor blackColor];
    
    //adding dropdown update feature fro collection view
    
    
    refreshControl=[[UIRefreshControl alloc]init];
    refreshControl.attributedTitle= [[NSAttributedString alloc] initWithString:@"Loading"];
    [self.jsonTable addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(changeSorting) forControlEvents:UIControlEventValueChanged];
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        // code for landscape orientation
    
    self.activityIndicatorView.frame = CGRectMake(350, 70, 37, 37);
    [self.view addSubview:self.activityIndicatorView];
    self.view.userInteractionEnabled = YES;
    [self.activityIndicatorView startAnimating];
    
    }
    else
    {
        self.activityIndicatorView.frame = CGRectMake(140, 236, 37, 37);
        [self.view addSubview:self.activityIndicatorView];
        self.view.userInteractionEnabled = YES;
        [self.activityIndicatorView startAnimating];
    }
    
    //show bar button in collection view according
    if([self.buttonDetailAdd isEqualToString:@"YES"])
    {
        self.buttonAddData.enabled=TRUE;
        //self.navigationItem.rightBarButtonItem = nil;
        //self.buttonAddData.
    }
    else
    {
        self.buttonAddData.enabled=FALSE;
        self.navigationItem.rightBarButtonItem = nil;
    }
    //prepare database
    
    [self prepareDatabase];
    
	jsonDict = [[NSDictionary alloc] init];
    photos = [[NSArray alloc] init];
    self.cachedImages = [[NSMutableDictionary alloc] init];
    NSString *setTitlepage=[[NSString alloc]initWithFormat:@"Photos of %@",self.getTitleofPage];
    self.title=setTitlepage;
    
    //url for flickr recent photo api recvied from table view or search
    url = [NSURL URLWithString:self.receiveUrl];
    self.jsonTable.indicatorStyle =UIScrollViewIndicatorStyleBlack;
    
    //flash scrollbar indicator for cellview table
    [self.jsonTable flashScrollIndicators];
    
    //sending url for json adding to dictionary
    [self parseJSONWithURL:url];
    
    self.labelNoData.hidden=YES;
    i=0;
   

}

- (void)changeSorting
{
    // NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc]initWithKey:nil ascending:self.ascending];
    
    // NSArray *sortDescriptors=@[sortDescriptor];
    ascending=!ascending;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self parseJSONWithURL:url];
    });
    [self performSelector:@selector(updateTable) withObject:nil afterDelay:3];
    
}

- (void) updateTable
{
    
    [refreshControl endRefreshing];
}


- (void) parseJSONWithURL:(NSURL *) jsonURL
{
    //checking internet connection while data is loading
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:jsonURL completionHandler:^(NSData *data,
                                                          NSURLResponse *response, NSError *error) {
        if (error != nil){
            NSLog(@"Error = %@", error);
            
            //running method in background to speed up the process
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to Flickr. Please make sure you are connected to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Retry",nil];
                    [self.activityIndicatorView startAnimating];
                [self.activityIndicatorView removeFromSuperview];
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

            
            
            // loading success.
            if (error == nil)
            {
                //running method in background to speed up the process
                dispatch_async(dispatch_get_main_queue(),
                ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    photos = [[jsonDict valueForKey:@"photos"] valueForKey:@"photo"];
                    
                    [self.jsonTable reloadData];
                    [self.activityIndicatorView stopAnimating];
                    [self.activityIndicatorView removeFromSuperview];
                    
                });
                
            }
            
            // failed, display error as alert.
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Uh Oh, Parsing Failed." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                
                [alertView show];
                [self.activityIndicatorView stopAnimating];
                [self.activityIndicatorView removeFromSuperview];
            }
        }

    });
}

//method to implement alertview button method
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==1)
    {
        [self.view addSubview:self.activityIndicatorView];
        self.view.userInteractionEnabled = YES;
        [self.activityIndicatorView startAnimating];
        [self parseJSONWithURL:url];
    }
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // NSLog(@"hey: %lu",(unsigned long)[photos count]);
    i++;
    if((i==2) && ([photos count]==0))
    {
        NSLog(@"hey: %lu",(unsigned long)[photos count]);
        self.labelNoData.hidden=NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Serach Data Found" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    return [photos count];
    [self.jsonTable reloadData];
}



-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    FC *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    
    //image link url
    self.urlLink=[[NSString alloc]initWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_s.jpg",[[photos objectAtIndex:indexPath.row] objectForKey:@"farm"],[[photos objectAtIndex:indexPath.row] objectForKey:@"server"],[[photos objectAtIndex:indexPath.row] objectForKey:@"id"],[[photos objectAtIndex:indexPath.row] objectForKey:@"secret"]];
    
    //adding inage from url to cellview by adding subview
    [cell.myImage addSubview:[self addViewWithURL:self.urlLink NFrame:CGRectMake(5, 5, 80, 80)]];
    
    return cell;
}

//method to call lazyload for cache and background image.
-(UIView*)addViewWithURL:(NSString*)urlStr NFrame:(CGRect)rect
{
    LazyLoad *lazyLoading;
    
    lazyLoading = [[LazyLoad alloc] init];
    [lazyLoading setFrame:rect];
    
    [lazyLoading loadImageFromURL:[NSURL URLWithString:urlStr]];
    return lazyLoading;
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 15, 5, 15);
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        
        //link for selected image url.
        self.urlLink=[[NSString alloc]initWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_n.jpg",[[photos objectAtIndex:indexPath.row] objectForKey:@"farm"],[[photos objectAtIndex:indexPath.row] objectForKey:@"server"],[[photos objectAtIndex:indexPath.row] objectForKey:@"id"],[[photos objectAtIndex:indexPath.row] objectForKey:@"secret"]];
        
        //sending data to next view controller by using segue push method.
        [[segue destinationViewController] setLoadUrl:self.urlLink];
        [[segue destinationViewController] setPhotoDateTaken:[[photos objectAtIndex:indexPath.row] objectForKey:@"datetaken"]];
        [[segue destinationViewController] setPhotoOwnerName:[[photos objectAtIndex:indexPath.row] objectForKey:@"ownername"]];
       
        NSString *checkTitlePhoto=[[photos objectAtIndex:indexPath.row] objectForKey:@"title"];
        if([checkTitlePhoto isEqualToString:@""])
        {
            checkTitlePhoto=@"No Title Avialiable";
        }
        [[segue destinationViewController] setPhotoTitle:checkTitlePhoto];
        
        
        [[segue destinationViewController] setPhotoTags:[[photos objectAtIndex:indexPath.row]objectForKey:@"tags"]];
        [[segue destinationViewController] setPhotoComputerTags:[[photos objectAtIndex:indexPath.row]objectForKey:@"machine_tags"]];
        [[segue destinationViewController] setPhotoID1:[[photos objectAtIndex:indexPath.row]objectForKey:@"id"]];
        
        [[segue destinationViewController] setPhotoLongitute:[[photos objectAtIndex:indexPath.row]objectForKey:@"longitude"]];
        [[segue destinationViewController] setPhotoLatitute:[[photos objectAtIndex:indexPath.row]objectForKey:@"latitude"]];
        
        
    }
}

// image request for caching the image
+ (NSMutableURLRequest *)imageRequestWithURL:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad; // this always returns the cached image
    request.HTTPShouldHandleCookies = NO;
    request.HTTPShouldUsePipelining = YES;
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    return request;
}

- (IBAction)addToDatabaseFav:(id)sender
{
        sqlite3_stmt    *statement;
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK) {
            
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO FLICKRTABLE (MESSAGE) VALUES (\"%@\")",
                                   self.getTitleofPage];
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(myDatabase, insert_stmt,
                               -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE) {
                statusOfAddingToDB = [NSString stringWithFormat:@"%@ -- Added to Favorite",self.getTitleofPage];
            } else {
                statusOfAddingToDB = @"Failed to add contact";
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:statusOfAddingToDB delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            sqlite3_finalize(statement);
            sqlite3_close(myDatabase);
            self.buttonAddData.enabled=FALSE;
            self.navigationItem.rightBarButtonItem = nil;
        }
}

- (void)prepareDatabase
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"flickrDatabase.db"]];
    NSLog(@"DB Path: %@", databasePath);
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS FLICKRTABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, MESSAGE TEXT)";
            
            if (sqlite3_exec(myDatabase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                statusOfAddingToDB = @"Failed to create table";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:statusOfAddingToDB delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                statusOfAddingToDB = @"Success in creating table";
                //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:statusOfAddingToDB delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //[alert show];
            }
            sqlite3_close(myDatabase);
        } else {
            statusOfAddingToDB = @"Failed to open/create database";
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
