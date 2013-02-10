//
//  GraphViewController.h
//  Calculator
//
//  Created by Phil Stahlfeld on 1/30/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController

@property (nonatomic, readonly) id program;

- (void) setProgram:(id)program;
- (void) setSplitViewBarButtonItem: (UIBarButtonItem *) splitViewBarButtonItem;
@end
