//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Phil Stahlfeld on 1/19/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize history = _history;

- (CalculatorBrain *)brain{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


- (void) addToHistory:(NSString *) itemToAdd{
    self.history.text = [self.history.text stringByAppendingString:itemToAdd];
}


- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    
    if (userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    [self addToHistory:digit];
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self addToHistory:@" "];
}


- (IBAction)actionPressed:(UIButton *)sender {
    
    if(self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    [self addToHistory:[NSString stringWithFormat:@"%@ ", operation]];
    
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
}
- (IBAction)clearDisplay {
    self.history.text = @"";
    self.display.text = @"0";
    [self.brain clearHistory];
}

- (IBAction)decimalPressed {
    
    [self addToHistory:@"."];
    
    NSRange range = [self.display.text rangeOfString:@"."];
    if (range.location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
    }
}

@end
