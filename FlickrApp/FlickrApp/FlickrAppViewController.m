//
//  FlickrAppViewController.m
//  FlickrApp
//
//  Created by Phil Stahlfeld on 2/17/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "FlickrAppViewController.h"
#import "FlickrFetcher.h"

@interface FlickrAppViewController ()

@end

@implementation FlickrAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testButtonPressed {
    NSArray *topPlaces = [FlickrFetcher topPlaces];
    NSDictionary *place = [topPlaces objectAtIndex:0];
    
    NSArray *photosFromPlace = [FlickrFetcher photosInPlace:place maxResults:50];
   
    NSDictionary *photoDict = [photosFromPlace objectAtIndex:0];

    NSLog([@"Photo dict:" stringByAppendingString:[photoDict objectForKey:@"title"]]);
}

@end
