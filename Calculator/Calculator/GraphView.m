//
//  GraphView.m
//  Calculator
//
//  Created by Phil Stahlfeld on 1/30/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"


@implementation GraphView

@synthesize scale = _scale;
@synthesize dataSource = _dataSource;

- (CGFloat) scale{
    if(!_scale)
        return 10;
    else
        return _scale;
}

- (void) setScale:(CGFloat)scale{
    _scale = scale;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) pinch:(UIPinchGestureRecognizer *) gesture{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       (gesture.state == UIGestureRecognizerStateEnded)){
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
    
}


- (void)drawRect:(CGRect)rect
{
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw axes
    
    CGRect bounds;
    bounds.origin.x = self.bounds.origin.x;
    bounds.origin.y = self.bounds.origin.y;
    bounds.size.height = self.bounds.size.height;
    bounds.size.width = self.bounds.size.width;
    
    CGPoint point;
    point.x = self.bounds.origin.x + self.bounds.size.width/2;
    point.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat scale = self.scale;
    
    [AxesDrawer drawAxesInRect:bounds originAtPoint:point scale:scale];
    
    [self.dataSource graphFunction:self];
}


- (void) drawPathFrom:(CGPoint)startingPoint to:(CGPoint)endingPoint{
    
    //NSLog(@"Drawing path");
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	UIGraphicsPushContext(context);
    
    CGPoint start;
    CGPoint end;
    CGPoint origin;
    
    origin.x = self.bounds.origin.x + self.bounds.size.width/2.0;
    origin.y = self.bounds.origin.y + self.bounds.size.height/2.0;
    
    start.x = origin.x + startingPoint.x * self.scale;
    end.x = origin.x + endingPoint.x * self.scale;
    
    start.y = origin.y - endingPoint.y * self.scale;
    end.y = origin.y - endingPoint.y * self.scale;
    
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, start.x, start.y);
	CGContextAddLineToPoint(context, end.x, end.y);
	CGContextStrokePath(context);
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(context, 3.0);
	
    
	UIGraphicsPopContext();
}


@end
