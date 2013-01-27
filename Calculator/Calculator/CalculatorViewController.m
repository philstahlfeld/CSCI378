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
@property (nonatomic, strong) NSDictionary *variableValues;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize history = _history;
@synthesize variableValues = _variableValues;
@synthesize variablesUsed = _variablesUsed;

- (CalculatorBrain *)brain{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (NSDictionary *) variableValues{
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    [objects addObject:[NSNumber numberWithInt:5]];
    
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    [keys addObject:@"x"];
    _variableValues = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    return _variableValues;
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
    
    [self.brain pushVariable:operation];
    double result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.variableValues];//[self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
    self.variablesUsed.text = [self.brain variablesUsedInProgram:self.variableValues];
}

- (IBAction)clearDisplay {
    [self.brain clearHistory];
    self.history.text = @"";
    self.display.text = @"0";
    self.variablesUsed.text = [self.brain variablesUsedInProgram:self.variableValues];
    
}

- (IBAction)decimalPressed {
    
    [self addToHistory:@"."];
    
    NSRange range = [self.display.text rangeOfString:@"."];
    if (range.location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
    }
}

@end
