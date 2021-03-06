//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Phil Stahlfeld on 1/19/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController <UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *history;
@property (weak, nonatomic) IBOutlet UILabel *variablesUsed;

@end
