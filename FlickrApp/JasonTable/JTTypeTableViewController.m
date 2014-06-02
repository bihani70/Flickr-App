//
//  JTTypeTableViewController.m
//  JasonTable
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "JTTypeTableViewController.h"
#import "FCViewController.h"
#import <sqlite3.h>

@interface JTTypeTableViewController ()
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *myDatabase;
@property (strong, nonatomic) NSString *statusOfGettingDataFromDB;
@property (strong, nonatomic) NSMutableArray *list;

@property (strong, nonatomic) NSString *statusOfAddingToDB;
@end

@implementation JTTypeTableViewController


@synthesize databasePath;
@synthesize myDatabase;
@synthesize statusOfGettingDataFromDB;
@synthesize list;
@synthesize statusOfAddingToDB;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"squaw_flat_iphone.png"]];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title=@"Flickr Photos";
    list = [[NSMutableArray alloc] init];
     
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [self getTextFomDB];
    [self.tableView reloadData];
}
- (void)getTextFomDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc]
                    initWithString: [docsDir stringByAppendingPathComponent:
                                     @"flickrDatabase.db"]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM FLICKRTABLE";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(myDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            [list removeAllObjects];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSString *textID = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                NSString *text = [[NSString alloc]
                                  initWithUTF8String:
                                  (const char *) sqlite3_column_text(
                                                                     statement, 1)];
                //[list addObject:[NSString stringWithFormat:@"%@: %@", textID, text]];
                [list addObject:text];
                statusOfGettingDataFromDB = @"Found!";
                NSLog(@"count:%@",text);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(myDatabase);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [list count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //[[cell textLabel]setText:[[self.arrayPhotoTag objectAtIndex:indexPath.row]objectForKey:@"name"]];
    // Configure the cell...
     cell.textLabel.text = [list objectAtIndex:indexPath.row];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Delete");
        NSString *docsDir;
        NSArray *dirPaths;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        // Build the path to the database file
        databasePath = [[NSString alloc]
                        initWithString: [docsDir stringByAppendingPathComponent:
                                         @"flickrDatabase.db"]];
        
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt    *statement;
        
        if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK)
        {
            NSString *querySQL = [[NSString alloc]initWithFormat:@"DELETE FROM FLICKRTABLE WHERE MESSAGE='%@'",[list objectAtIndex:indexPath.row]];
            NSLog(@"%@",querySQL);
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(myDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                [list removeAllObjects];
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *text = [[NSString alloc]
                                      initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 1)];
            
                    [list addObject:text];
                    statusOfGettingDataFromDB = @"Found!";
                    NSLog(@"count:%@",text);
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(myDatabase);
            
        }
        [self viewWillAppear:YES];
    }   
   // [self.tableView reloadData];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *part1=@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4c1fa4212b6f2cccc4cadcca4759c97c&tags=";
        NSString *part2;
        NSString *part3;
        NSString *part4;
        part2=[[NSString alloc]initWithString:[list objectAtIndex:indexPath.row]];
        part2=[part2 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        part3=@"&text=";
        part4=[list objectAtIndex:indexPath.row];
        part4=[part4 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *part5=@"&sort=relevance&accuracy=3&extras=owner_name%2Cdate_upload%2C+date_taken%2Cdescription%2Ctags%2Cgeo%2Cmachine_tags&format=json&nojsoncallback=1";
                self.sendUrl=[[NSString alloc]initWithFormat:@"%@%@%@%@%@",part1,part2,part3,part4,part5];
        //NSLog(@"hello %@",self.sendUrl);
      //  NSLog(@"hello123 %@",new12);
        [[segue destinationViewController] setReceiveUrl:self.sendUrl];
        [[segue destinationViewController] setGetTitleofPage:[list objectAtIndex:indexPath.row]];
    }
}






@end
