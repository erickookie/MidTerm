//
//  DrawLinesViewController.m
//  MidTerm
//
//  Created by MCS on 8/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

//#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
//#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]


#import "DrawLinesViewController.h"
#import "TouchTrackerView.h"

@interface DrawLinesViewController ()

//@property (nonatomic) BOOL touched;
//@property (nonatomic) CGPoint firstTouch;
//@property (nonatomic) CGPoint secondTouch;
//@property (nonatomic) int tapCount;

@end

@implementation DrawLinesViewController

#pragma mark - View Did Load
- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    self.mainImage.hidden = YES;
    self.tempDrawImage.hidden = YES;
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Buttons
- (IBAction)pencilPressed:(id)sender
{
    NSLog(@"Drawing Line Button Pressed");
    UIButton * PressedButton = (UIButton*)sender;
    switch(PressedButton.tag)
    {
        case 0:
            NSLog(@"Black Color");
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            [self.trackerView setColorForDrawing:[UIColor colorWithRed:red green:green blue:blue alpha:1.0f]];
            break;
        case 1:
            NSLog(@"Red Color");
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            self.trackerView.colorForDrawing = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
            break;
        case 2:
            NSLog(@"Blue Color");
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            self.trackerView.colorForDrawing = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
            break;
        case 3:
            NSLog(@"Green Color");
            red = 0.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            self.trackerView.colorForDrawing = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
            break;
    }
    self.trackerView.PencilSelected=YES;
    self.trackerView.CircleSelected=NO;
}

- (IBAction)eraserPressed:(id)sender
{
    NSLog(@"Erase Pressed");
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    opacity = 1.0;
    self.trackerView.colorForDrawing = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (IBAction)reset:(id)sender
{
    NSLog(@"Reset Pressed");
//    self.mainImage.image = nil;
//    self.tempDrawImage.image = nil;
    [(TouchTrackerView *)self.trackerView clear];
    
}

- (IBAction)save:(id)sender
{
    NSLog(@"Save Pressed");
}

- (IBAction)circle:(id)sender
{
    NSLog(@"call the Methods to draw the Circle");
    
     [(TouchTrackerView *)self.trackerView circle];
}

//****************************************************************************************************************************************************************
//
//- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
//{
//    NSLog(@"Touch Began");
//    for (UITouch *touch in touches)
//    {
//        NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
//        CGPoint pt = [touch locationInView:self.tempDrawImage];
//        CGPoint pt2 = [touch locationInView:self.mainImage];
//        
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        path.lineWidth = IS_IPAD? 8: 4;
//        path.lineCapStyle = kCGLineCapRound;
//        [path moveToPoint:pt];
//        [path moveToPoint:pt2];
//        
//        [touchPaths setObject:path forKey:key];
//        
//            mouseSwiped = NO;
//            UITouch *touch = [touches anyObject];
//            lastPoint = [touch locationInView:self.view];
//    }    
//}
////
//- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
//{
//    NSLog(@"Touch Moved");
//    for (UITouch *touch in touches)
//    {
//        NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
//        UIBezierPath *path = [touchPaths objectForKey:key];
//        if (!path) break;
//        
//        CGPoint pt = [touch locationInView:self.tempDrawImage];
//        CGPoint pt2 = [touch locationInView:self.mainImage];
//        [path addLineToPoint:pt];
//        [path addLineToPoint:pt2];
//    }	
//    
////    [self setNeedsDisplay];
//    [self tempDrawImage];
//    [self mainImage];
//}
//
//- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touch Ended");
//    for (UITouch *touch in touches)
//    {
//        NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
//        UIBezierPath *path = [touchPaths objectForKey:key];
//        if (path) [strokes addObject:path];
//        [touchPaths removeObjectForKey:key];
//    }
//    
////    [self setNeedsDisplay];
//    [self tempDrawImage];
//    [self mainImage];
//}
//
//- (void) drawRect:(CGRect)rect
//{
//    [COOKBOOK_PURPLE_COLOR set];
//    for (UIBezierPath *path in strokes)
//        [path stroke];
//    
//    [[COOKBOOK_PURPLE_COLOR colorWithAlphaComponent:0.5f] set];
//    for (UIBezierPath *path in [touchPaths allValues])
//        [path stroke];
//}

//****************************************************************************************************************************************************************

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Toach Began");
//    UITouch *touch = [touches anyObject];
//    lastPoint = [touch locationInView:self.view];
//    
//    
//    
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//{
//    NSLog(@"Toach Moved");
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//{
//    NSLog(@"Toach Ended");
//}
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
//{
//    NSLog(@"Toach Cancelled");
//}

//// Touch Events

//#pragma mark - Touch events
//#pragma mark * Touch Began
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touch Began");
//    self.view.multipleTouchEnabled=YES;
//    
//    mouseSwiped = NO;
//    UITouch *touch = [touches anyObject];
//    lastPoint = [touch locationInView:self.view];
//    
//    UITouch *touch2 = [touches anyObject];
//    previousPoint = [touch2 locationInView:self.view]; // take the starting touch point;
//    
//}
//
//#pragma  mark * Touch Moved
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touch Moved");
//    
//    self.view.multipleTouchEnabled=YES;
//    mouseSwiped = YES;
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:self.view];
//    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    
//    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
//    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
//    
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
//    [self.tempDrawImage setAlpha:opacity];
//    UIGraphicsEndImageContext();
//    
//    lastPoint = currentPoint;
//}
//
//#pragma  mark * touch Ended
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    self.view.multipleTouchEnabled=YES;
//    NSLog(@"Touch Ended");
//}
//*****************************************************************************************************************************************************************

@end
