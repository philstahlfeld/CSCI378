//
//  GraphViewController.m
//  Calculator
//
//  Created by Phil Stahlfeld on 1/30/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
#import "CalculatorBrain.h"

@interface GraphViewController () <GraphViewDataSource>
@property (nonatomic, weak) IBOutlet GraphView *graphView;
@end

@implementation GraphViewController

@synthesize graphView = _graphView;
@synthesize program = _program;

- (void) setProgram:(id)program{
    _program = program;
}

- (void) setGraphView:(GraphView *)graphView{
    _graphView = graphView;
    [self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pinch:)]];
    
    self.graphView.dataSource = self;
}


- (void) graphFunction:(GraphView *)sender{

#define NUMBER_OF_POINTS 10000;
    
    CGFloat deltaX = sender.bounds.size.width/sender.scale/NUMBER_OF_POINTS;
    
    
    
    
    CGPoint start;
    CGPoint end;
    start.x = -1 * sender.bounds.size.width/sender.scale/2.0;
    
    NSMutableDictionary *variableValue = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:start.x], @"x", nil];
    start.y = [CalculatorBrain runProgram:self.program usingVariableValues:variableValue];
    
    while(start.x <= sender.bounds.size.width/sender.scale/2.0){
        
        end.x = start.x + deltaX;
        [variableValue setObject:[NSNumber numberWithFloat:end.x] forKey:@"x"];
        end.y = [CalculatorBrain runProgram:self.program usingVariableValues:variableValue];
        
        
        [sender drawPathFrom:start to:end];
        
        start = end;
        
    }
}

@end
