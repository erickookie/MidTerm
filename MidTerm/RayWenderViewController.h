//
//  RayWenderViewController.h
//  MidTerm
//
//  Created by MCS on 8/31/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fuzz.h"

@interface RayWenderViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *rayWebSite;

@property (nonatomic, strong)  Fuzz * newsInformation;

@end
