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
- (void) pushVariable: (NSString *) variable;
- (double) performOperation:(NSString *) operation;
- (void) clearHistory;
- (NSString *) variablesUsedInProgram: (NSDictionary *) variableValues;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;
+ (double) runProgram:(id)program usingVariableValues:(NSDictionary *) variableValues;

@end
