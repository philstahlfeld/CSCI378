//
//  TopPlacesTableViewController.m
//  FlickrApp
//
//  Created by Phil Stahlfeld on 2/17/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoTableViewController.h"

@interface TopPlacesTableViewController ()
@property (nonatomic, strong) NSArray *topPlaces;
@property (nonatomic, strong) NSIndexPath *chosenLocation;

@end

@implementation TopPlacesTableViewController

@synthesize topPlaces = _topPlaces;
@synthesize chosenLocation = _chosenLocation;

- (NSArray *)topPlaces{
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
    dispatch_async(downloadQueue, ^{
        if(! _topPlaces) _topPlaces = [FlickrFetcher topPlaces];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
    //NSLog(@"Returning top places");
    return _topPlaces;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Trending Places";

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
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.topPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Top Flickr Place";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *locationDict = [self.topPlaces objectAtIndex:indexPath.row];
    NSArray *locationDetailList = [[locationDict valueForKey:@"_content"] componentsSeparatedByString:@", "];
    
    NSUInteger numberOfLocationDetails = [locationDetailList count];
    
    NSString *city = [locationDetailList objectAtIndex:0];
    NSString *state;
    NSString *province;
    if(numberOfLocationDetails > 1) state = [locationDetailList objectAtIndex:1];
    if(numberOfLocationDetails > 2) province = [locationDetailList objectAtIndex:2];
    
    NSString *stateProvince;
    if(numberOfLocationDetails > 2){
        stateProvince = [[state stringByAppendingString:@", "] stringByAppendingString:province];
    }else if (numberOfLocationDetails > 1){
        stateProvince = state;
    }else{
        stateProvince = @"";
    }
    
    cell.textLabel.text = city;
    cell.detailTextLabel.text = stateProvince;
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    //[self performSegueWithIdentifier:@"ShowPhotoForPlace" sender:self];
    self.chosenLocation = indexPath;
    [self performSegueWithIdentifier:@"ShowPhotoForPlace" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowPhotoForPlace"]){
        NSDictionary *locationDict = [self.topPlaces objectAtIndex:self.chosenLocation.row];
        NSArray *locationDetailList = [[locationDict valueForKey:@"_content"] componentsSeparatedByString:@", "];

        NSString *location;
        location = [locationDetailList objectAtIndex:0];
        [segue.destinationViewController setTitle:location];
        [segue.destinationViewController setPhotosFromLocation:[FlickrFetcher photosInPlace:locationDict maxResults:50]];
    }
}


@end
