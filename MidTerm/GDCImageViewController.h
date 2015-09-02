//
//  GDCImageViewController.h
//  MidTerm
//
//  Created by MCS on 8/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDCImageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    integer_t * selectedSegment;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong,nonatomic) NSMutableArray * fuzzArray;
@property (strong,nonatomic) NSMutableArray * textArray;
@property (strong,nonatomic) NSMutableArray * imagesArray;
@property (strong,nonatomic) NSMutableArray * otherArray;

@property (strong,nonatomic) NSMutableArray * text;
@property (strong,nonatomic) NSMutableArray * images;
@property (strong,nonatomic) NSMutableArray * other;

@property (strong,nonatomic) NSMutableArray * rayArray;

@property (strong, nonatomic) UIImageView * imageView;

@end
