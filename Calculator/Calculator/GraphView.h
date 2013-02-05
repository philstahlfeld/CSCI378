//
//  GraphView.h
//  Calculator
//
//  Created by Phil Stahlfeld on 1/30/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;

@protocol GraphViewDataSource

- (void) graphFunction: (GraphView *) sender;

@end

@interface GraphView : UIView

@property (nonatomic) CGFloat scale;
- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)drawPathFrom:(CGPoint) startingPoint
              to: (CGPoint) endingPoint;
@property (nonatomic, weak) IBOutlet id <GraphViewDataSource> dataSource;

@end
