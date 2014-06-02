//
//  FCDatabaseViewController.m
//  FlickrAPP
//
//  Created by Ravi Bihani on 05/12/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "FCDatabaseViewController.h"
#import <sqlite3.h>

@interface FCDatabaseViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *myDatabase;
@property (strong, nonatomic) NSString *statusOfAddingToDB;
@end

@implementation FCDatabaseViewController
@synthesize textField;
@synthesize databasePath;
@synthesize myDatabase;
@synthesize statusOfAddingToDB;

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
    [self prepareDatabase];
    
    self.ImageBackground.image= [UIImage imageNamed:@"squaw_flat_iphone.png"];
    [self.view sendSubviewToBack:self.ImageBackground];
    
    //handle backgrounf touch
    UITapGestureRecognizer* tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:tapRecognizer];
    [self.textField becomeFirstResponder];
    self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToDatabase:(id)sender {
    
    if([self.textField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:@"No Data Entered" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
    else
    {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO FLICKRTABLE (MESSAGE) VALUES (\"%@\")",
                               self.textField.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(myDatabase, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            statusOfAddingToDB = [NSString stringWithFormat:@"%@ -- Added to Favorite", textField.text];
        } else {
            statusOfAddingToDB = @"Failed to Add Favorite";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:statusOfAddingToDB delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        sqlite3_finalize(statement);
        sqlite3_close(myDatabase);
    }
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.addTextButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    return YES;
}

-(void) handleBackgroundTap:(UITapGestureRecognizer*) sender
{
    [self.textField resignFirstResponder];
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
@end
