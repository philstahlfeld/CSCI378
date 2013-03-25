//
//  PropaneFetcher.m
//  ProPANE Viewer
//
//  Created by Phil Stahlfeld on 3/18/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "PropaneFetcher.h"

#define IMAGE_SERVER_URL @"http://propane.stahlfeld.com/api/"

@implementation PropaneFetcher

+ (NSDictionary *) executeQuery: (NSString *) query{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return results;
}

+ (NSArray *) captureList{
    NSString *query = [IMAGE_SERVER_URL stringByAppendingString:@"capture_list.php"];
    NSDictionary *results = [PropaneFetcher executeQuery:query];
    return [results objectForKey:@"captures"];
}

+ (NSArray *) imagesInCapture:(NSString *)captureFilename{
    NSString *query = [IMAGE_SERVER_URL stringByAppendingFormat:@"image_list.php?capture_file=%@", captureFilename];
    NSDictionary *results = [PropaneFetcher executeQuery:query];
    return [results objectForKey:@"images"];
}

@end
