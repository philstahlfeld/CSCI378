//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Phil Stahlfeld on 1/20/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand: (double) operand;
- (double) performOperation:(NSString *) operation;
- (void) clearHistory;

@end
