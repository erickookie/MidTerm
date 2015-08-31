//
//  PaintView.h
//  MidTerm
//
//  Created by MCS on 8/30/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

typedef enum shapeTypes
{
    linesShape,
    rectangleShape,
    circleShape
} ShapeType;

#import <UIKit/UIKit.h>

@interface PaintView : UIView
{
    ShapeType currentShapeType;
}

@property (nonatomic) BOOL touched;
@property (nonatomic) CGPoint locationOfTouch;

- (id)initWithFrame:(CGRect)frame shape:(int)shape;

@end
