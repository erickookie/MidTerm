//
//  TouchTrackerView.h
//  MidTerm
//
//  Created by MCS on 8/30/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define IS_IPAD	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define RESIZABLE(_VIEW_) [_VIEW_ setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth]

#import <UIKit/UIKit.h>

@interface TouchTrackerView : UIView
{
    NSMutableArray *strokes;
    NSMutableArray *allStrokes;
    NSMutableDictionary *touchPaths;
   
    
}
@property (nonatomic) BOOL * CircleSelected;
@property (nonatomic) BOOL * PencilSelected;

@property (nonatomic) UIColor *colorForDrawing;

@property (nonatomic) BOOL touched;
@property (nonatomic) CGPoint locationOfTouch;

- (void) clear;
- (void) circle;
+ (void)setColor:(UIColor*)color;

@end
