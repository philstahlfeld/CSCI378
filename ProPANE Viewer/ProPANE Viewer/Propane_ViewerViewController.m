//
//  Propane_ViewerViewController.m
//  ProPANE Viewer
//
//  Created by Phil Stahlfeld on 3/18/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "Propane_ViewerViewController.h"
#import "PropaneFetcher.h"

@interface Propane_ViewerViewController ()

@end

@implementation Propane_ViewerViewController

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

- (IBAction)test {
    NSDictionary *results = [PropaneFetcher captureList];
    NSArray *captureArray = [results objectForKey:@"captures"];
    NSLog([[captureArray objectAtIndex:0] objectForKey:@"title"]);
}



@end
