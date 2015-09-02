    //
//  TouchTrackerView.m
//  MidTerm
//
//  Created by MCS on 8/30/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//



#import "TouchTrackerView.h"

@interface TouchTrackerView ()

//@property (nonatomic) BOOL * CircleSelected;

@end

@implementation TouchTrackerView

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self.CircleSelected = nil;
    self.PencilSelected = YES;
    if (self = [super initWithCoder:aDecoder])
    {
        self.multipleTouchEnabled = YES;
        strokes = [NSMutableArray array];
        allStrokes = [NSMutableArray array];
        touchPaths = [NSMutableDictionary dictionary];
        self.colorForDrawing = COOKBOOK_PURPLE_COLOR;
    }
    return self;
    
}


- (void) clear
{
    [strokes removeAllObjects];
    [allStrokes removeAllObjects];
    [self setNeedsDisplay];
}

-(void) circle
{
//    NSLog(@"This is the funtions for the Button to draw a circle");
    self.CircleSelected = YES;
    
    if (self.CircleSelected == YES)
    { NSLog(@"The circle button has selected"); }
}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
//************  Working Code ... Dont Delete, just Commnet ***********
    
        NSLog(@"Draw with the pencil");
        for (UITouch *touch in touches)
        {
            NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
            CGPoint pt = [touch locationInView:self];
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            path.lineWidth = IS_IPAD? 8: 4;
            path.lineCapStyle = kCGLineCapRound;
            [path moveToPoint:pt];
            [touchPaths setObject:path forKey:key];
        }
//************  Working Code ... Dont Delete, just Commnet ***********
}

- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    for (UITouch *touch in touches)
    {
        NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
        UIBezierPath *path = [touchPaths objectForKey:key];
        if (!path) break;
        
        CGPoint pt = [touch locationInView:self];
        [path addLineToPoint:pt];
    }
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
        UIBezierPath *path = [touchPaths objectForKey:key];
        if (path)
        {
            [strokes addObject:@[path,self.colorForDrawing]];
            [allStrokes addObject:path];
        }
        [touchPaths removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void) drawRect:(CGRect)rect
{
    if (self.CircleSelected == YES)
    {
        NSLog(@"Funtions to draw a circle inside the drawRect Method");
        
        
        CGContextRef ctx= UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        CGContextSetLineWidth(ctx,5);
        CGContextSetRGBStrokeColor(ctx,0.8,0.8,0.8,1.0);
        CGContextAddArc(ctx,_locationOfTouch.x,_locationOfTouch.y,30,0.0,M_PI*2,YES);
        CGContextStrokePath(ctx);
        
        
    }
    else if(self.PencilSelected == YES)
    {
        NSLog(@"Funtions to draw a line insite the drawRect Method");
        
        for (NSArray *obj in strokes)
        {
            [(UIColor*)obj[1] set];
            UIBezierPath *path = obj[0];
            [path stroke];
        }
        
        [[self.colorForDrawing colorWithAlphaComponent:0.5f]set];
        for (UIBezierPath *path in [touchPaths allValues])
            [path stroke];
    }
}



-(void)drawTouchCircle:(CGPoint)locationOfTouch
{
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetLineWidth(ctx,5);
    CGContextSetRGBStrokeColor(ctx,0.8,0.8,0.8,1.0);
    CGContextAddArc(ctx,locationOfTouch.x,locationOfTouch.y,30,0.0,M_PI*2,YES);
    CGContextStrokePath(ctx);
}

-(void)setColor:(UIColor *)color
{
    self.colorForDrawing = color;
}

@end
