//
//  NewsWebViewController.h
//  MidTerm
//
//  Created by MCS on 8/28/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsWebViewController : UIViewController

@property (nonatomic, strong) News * newsOriginalSite;

@property (nonatomic, strong) NSMutableArray * urlSiteWebView;
@property (strong, nonatomic) IBOutlet UIWebView *urlOriginalSiteWebView;


@end
