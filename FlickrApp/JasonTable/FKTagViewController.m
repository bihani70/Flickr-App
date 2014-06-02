//
//  FKTagViewController.m
//  FlickrAPP
//
//  Created by Mr Ravi Bihani on 18/12/2013.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "FKTagViewController.h"
#import "FCViewController.h"

@interface FKTagViewController ()

@end

@implementation FKTagViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"squaw_flat_iphone.png"]];
    
    NSLog(@"hello tahgs %@",self.recieveTag2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.recieveTag2 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.recieveTag2 objectAtIndex:indexPath.row];
    return cell;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *part1=@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4c1fa4212b6f2cccc4cadcca4759c97c&tags=";
        NSString *part2;
        NSString *part3;
        NSString *part4;
        part2=[[NSString alloc]initWithString:[self.recieveTag2 objectAtIndex:indexPath.row]];
        part2=[part2 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        part3=@"&text=";
        part4=[self.recieveTag2 objectAtIndex:indexPath.row];
        part4=[part4 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *part5=@"&sort=relevance&accuracy=3&extras=owner_name%2Cdate_upload%2C+date_taken%2Cdescription%2Ctags%2Cgeo%2Cmachine_tags&format=json&nojsoncallback=1";
        self.sendUrl2=[[NSString alloc]initWithFormat:@"%@%@%@%@%@",part1,part2,part3,part4,part5];
        //NSLog(@"hello %@",self.sendUrl);
        //  NSLog(@"hello123 %@",new12);
        [[segue destinationViewController] setReceiveUrl:self.sendUrl2];
        [[segue destinationViewController] setGetTitleofPage:[self.recieveTag2 objectAtIndex:indexPath.row]];
        [[segue destinationViewController] setButtonDetailAdd:@"YES"];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
