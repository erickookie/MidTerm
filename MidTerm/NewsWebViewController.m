//
//  newsDetailViewController.m
//  MidTerm
//
//  Created by MCS on 8/28/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "NewsWebViewController.h"

@implementation NewsWebViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"This is the Web View for the Original New");
    
    NSLog(@"Original WebSite URL from the Last Segue -> %@", self.urlSiteWebView);
   
    NSString * urlString = self.urlSiteWebView;
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    [self.urlOriginalSiteWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
