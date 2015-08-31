//
//  NewFeedViewController.h
//  MidTerm
//
//  Created by MCS on 8/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "XMLParson.h"
#import "JSONParsing.h"
#import "News.h"

//@interface NewFeedViewController : UIViewController 
@interface NewFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)UIImageView *onButtonView;
@property BOOL changeimagetype;
@property (strong, nonatomic) UIButton *mimageButton;

@property (strong,nonatomic) NSMutableArray * newsArray;

@property (strong, nonatomic) NSMutableArray * SelectFromDBArray;

@end
