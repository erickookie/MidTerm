//
//  newsDetailViewController.h
//  MidTerm
//
//  Created by MCS on 8/28/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface newsDetailViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *urlNewsImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleNewsLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionNewsLabel;
@property (strong, nonatomic) IBOutlet UILabel *urlNewLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageNewURL;

@property (nonatomic, strong) News * newsInformation;

@property (nonatomic, strong) IBOutlet UIButton *VisitPageActionButton;

@property (nonatomic, strong) NSMutableArray * newsCleanURL;

@end

