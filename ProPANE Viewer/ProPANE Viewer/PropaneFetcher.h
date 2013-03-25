//
//  PropaneFetcher.h
//  ProPANE Viewer
//
//  Created by Phil Stahlfeld on 3/18/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropaneFetcher : NSObject
+ (NSArray *) captureList;
+ (NSArray *) imagesInCapture: (NSString *) captureFilename;
@end
