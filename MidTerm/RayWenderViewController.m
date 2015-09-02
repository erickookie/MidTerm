//
//  RayWenderViewController.m
//  MidTerm
//
//  Created by MCS on 8/31/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "RayWenderViewController.h"

@implementation RayWenderViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"This is the Web View for the Original New");
    
    NSLog(@"RayWender WebSite URL from the Last Segue ");
    
    NSString * urlString = @"http://www.raywenderlich.com";
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    [self.rayWebSite loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
