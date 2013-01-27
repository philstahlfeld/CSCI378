//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Phil Stahlfeld on 1/20/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;

@end


@implementation CalculatorBrain

@synthesize programStack = _programStack;


- (NSMutableArray *) programStack{
    
    if (!_programStack){
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}



- (id)program{
    return [self.programStack copy];
}

+ (NSString *) descriptionOfProgram:(id)program{
    return nil;
}

- (void) pushOperand:(double)operand{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.programStack addObject:operandObject];
}

- (void) pushVariable:(NSString *)variable{
    [self.programStack addObject:variable];
}

- (void) clearHistory{
    [self.programStack removeAllObjects];
}


- (double) popOperand{
    NSNumber *operandObject = [self.programStack lastObject];
    if (operandObject) [self.programStack removeLastObject];
    return [operandObject doubleValue];
}

- (NSString *) variablesUsedInProgram:(NSDictionary *) variableValues{
    
    NSString *variableString = @"";
    
    NSSet *operators = [[NSSet alloc] initWithObjects:@"+", @"*", @"-", @"/", @"sin", @"cos", @"sqrt", @"π", nil];
    
    // Replace variables with values in stack
    NSString *variable;
    for(NSUInteger index = 0; index < [self.programStack count]; index++){
        variable = [self.programStack objectAtIndex:index];
        
        // if this item on the stack is not an operator
        if([variable isKindOfClass:[NSString class]] && ![operators containsObject:variable]){
            
            
            
            NSNumber *value = [variableValues objectForKey:variable];
            
            if(value)
                variableString = [variableString stringByAppendingString:[NSString stringWithFormat:@" %@ = %f", variable, [value doubleValue]]];
            else
                variableString = [variableString stringByAppendingString:[NSString stringWithFormat:@" %@ = 0", variable]];
        }
    }

    return variableString;
    
}


- (double) performOperation:(NSString *) operation{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (double) popOperandOffProgramStack: (NSMutableArray *) stack{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }else if ([topOfStack isKindOfClass:[NSString class]]){
        
        NSString *operation = topOfStack;
    
        if([operation isEqualToString:@"+"]){
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack];
        }else if ([operation isEqualToString:@"*"]){
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack];
        }else if ([operation isEqualToString:@"-"]){
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        }else if ([operation isEqualToString:@"/"]){
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        }else if ([operation isEqualToString:@"sin"]){
            result = sin([self popOperandOffProgramStack:stack]);
        }else if ([operation isEqualToString:@"cos"]){
            result = cos([self popOperandOffProgramStack:stack]);
        }else if([operation isEqualToString:@"sqrt"]){
            result = sqrt([self popOperandOffProgramStack:stack]);
        }else if ([operation isEqualToString:@"π"]){
            result = 3.14159;
        }
    }
    
    return result;
}


+ (double) runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    
    NSSet *operators = [[NSSet alloc] initWithObjects:@"+", @"*", @"-", @"/", @"sin", @"cos", @"sqrt", @"π", nil];
    
    // Replace variables with values in stack
    NSString *variable;
    for(NSUInteger index = 0; index < [stack count]; index++){
        variable = [stack objectAtIndex:index];
        
        // if this item on the stack is not an operator
        if([variable isKindOfClass:[NSString class]] && ![operators containsObject:variable]){
            
            NSNumber *value = [variableValues objectForKey:variable];
            
            if(value)
                [stack replaceObjectAtIndex:index withObject:value];
            else
                [stack replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:0]];
        }
    }
    
    return [self popOperandOffProgramStack:stack];
    
}

+ (double) runProgram:(id)program{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}

@end
