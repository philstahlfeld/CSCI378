//
//  CapturesListTableViewController.m
//  ProPANE Viewer
//
//  Created by Phil Stahlfeld on 3/18/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "CapturesListTableViewController.h"
#import "PropaneFetcher.h"
#import "ImagesInCaptureTableViewController.h"

@interface CapturesListTableViewController ()

@end

@implementation CapturesListTableViewController

@synthesize captures = _captures;

- (NSArray *) captures{
    if(!_captures){
        _captures = [PropaneFetcher captureList];
    }
    return _captures;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.captures count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CaptureListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *imageCount = [[self.captures objectAtIndex:indexPath.row] objectForKey:@"imageCount"];
    imageCount = [NSString stringWithFormat:@"%@ images", imageCount];
    cell.textLabel.text = [[self.captures objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = imageCount;
    
    return cell;
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


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowImagesInCapture"]){
        NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
        
        if([segue.destinationViewController isKindOfClass:[ImagesInCaptureTableViewController class]]){
            ImagesInCaptureTableViewController *destinationViewController = segue.destinationViewController;
            destinationViewController.capture = [self.captures objectAtIndex:selected.row];
        }
        
    }
    
}

@end
