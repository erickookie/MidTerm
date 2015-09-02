//
//  DrawLinesViewController.h
//  MidTerm
//
//  Created by MCS on 8/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define IS_IPAD	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define RESIZABLE(_VIEW_) [_VIEW_ setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth]

#import <UIKit/UIKit.h>
#import "TouchTrackerView.h"
@interface DrawLinesViewController : UIViewController <UIActionSheetDelegate, UIGestureRecognizerDelegate>
{
    CGPoint previousPoint;
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    
    NSMutableArray *strokes;
    NSMutableDictionary *touchPaths;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

@property (strong, nonatomic) IBOutlet TouchTrackerView *trackerView;

- (IBAction)pencilPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction)circle:(id)sender;

//- (void) clear;

@end
