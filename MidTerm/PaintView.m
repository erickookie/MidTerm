//
//  PaintView.m
//  MidTerm
//
//  Created by MCS on 8/30/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "PaintView.h"

@implementation PaintView

- (id)initWithFrame:(CGRect)frame shape:(int)shape;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        currentShapeType = shape;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    switch (currentShapeType)
    {
        case linesShape:
            [self drawLines];
            break;
        case rectangleShape:
            [self drawRectangle];
            break;
        case circleShape:
            [self drawCircle];
            break;
        default:
            break;
    }
}

- (void)drawLines
{
    //1
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 20.0, 20.0);
    CGContextAddLineToPoint(ctx, 250.0, 100.0);
    CGContextAddLineToPoint(ctx, 100.0f, 200.0f);
    CGContextSetLineWidth(ctx, 5);
    
    //3
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}

- (void)drawRectangle
{
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    float rectangleWidth = 100.0;
    float rectangleHeight = 100.0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //4
    CGContextAddRect(ctx, CGRectMake(center.x - (0.5 * rectangleWidth), center.y - (0.5 * rectangleHeight), rectangleWidth, rectangleHeight));
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor grayColor] CGColor]);
    CGContextStrokePath(ctx);
    
    //5
    CGContextSetFillColorWithColor(ctx, [[UIColor greenColor] CGColor]);
    CGContextAddRect(ctx, CGRectMake(center.x - (0.5 * rectangleWidth), center.y - (0.5 * rectangleHeight), rectangleWidth, rectangleHeight));
    CGContextFillPath(ctx);
}

- (void)drawCircle
{
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    
    //6 CGContextSetLineWidth(ctx, 5);
    CGContextAddArc(ctx, center.x, center.y, 100.0, 0, 2*M_PI, 0);
    CGContextStrokePath(ctx);
}

@end
