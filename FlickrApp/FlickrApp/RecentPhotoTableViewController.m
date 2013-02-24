//
//  RecentPhotoTableViewController.m
//  FlickrApp
//
//  Created by Phil Stahlfeld on 2/24/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "RecentPhotoTableViewController.h"
#import "FlickrFetcher.h"

@interface RecentPhotoTableViewController ()
@property (nonatomic, strong) NSArray *recentPhotoDicts;
@property (nonatomic, strong) UIImage *chosenImage;

@end

@implementation RecentPhotoTableViewController
@synthesize recentPhotoDicts = _recentPhotoDicts;
@synthesize chosenImage = _chosenImage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define RECENT_KEY @"PhotoTableViewController.Recent"
- (NSArray *) recentPhotoDicts{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _recentPhotoDicts = [defaults objectForKey:RECENT_KEY];
    return _recentPhotoDicts;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentPhotoDicts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Recent Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSUInteger reverseIndex = [self.recentPhotoDicts count] - indexPath.row - 1;
    NSDictionary *photoDict = [self.recentPhotoDicts objectAtIndex:reverseIndex];
    cell.textLabel.text = [photoDict objectForKey:@"title"];
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger reverseIndex = [self.recentPhotoDicts count] - indexPath.row - 1;
    NSDictionary *photoDict = [self.recentPhotoDicts objectAtIndex:reverseIndex];
    NSURL *photoURL = [FlickrFetcher urlForPhoto:photoDict format:FlickrPhotoFormatLarge];
    NSData *imageURLData = [NSData dataWithContentsOfURL:photoURL];
    self.chosenImage = [UIImage imageWithData:imageURLData];
    [self performSegueWithIdentifier:@"Show Recent Photo" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Show Recent Photo"]){
        [segue.destinationViewController setImage:self.chosenImage];
    }
}

@end
