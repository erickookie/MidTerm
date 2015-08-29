//
//  newsDetailViewController.m
//  MidTerm
//
//  Created by MCS on 8/28/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "newsDetailViewController.h"
#import "NewsWebViewController.h"

@implementation newsDetailViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    News * newsDetails = [[News alloc] init];
    
          _titleNewsLabel.text = self.newsInformation.TitleNew;
    //_descriptionNewsLabel.text = self.newsInformation.DescriptionsNew;
             //_urlNewLabel.text = self.newsInformation.urlNew;

    NSLog(@" *******  Working with the URL *******");
    NSLog(@" News Title ->%@", self.newsInformation.TitleNew);
    
// Clean the URL to open the WebView with the URL
    NSString * ClearURL = self.newsInformation.urlNew;
    //NSLog(@"FULL URL -> %@", ClearURL);
    NSArray *urlList = [ClearURL componentsSeparatedByString:@"="];
    //NSLog(@"Clean URL -> %@", [urlList objectAtIndex:1]);
    NSString * CleanURL = [urlList objectAtIndex:1];
//    _urlNewLabel.text = CleanURL;
    
//Clean the Description Element to get just the Description Text
    NSString * getDescription = self.newsInformation.DescriptionsNew;
    //NSLog(@"Full Description -> %@", getDescription);
    NSArray * descriptionText = [getDescription componentsSeparatedByString:@"<font size=\"-1\">"];
    descriptionText = [[descriptionText objectAtIndex:2] componentsSeparatedByString:@"<b>...</b>"];
    NSLog(@"Clean Description ->%@", [descriptionText objectAtIndex:0]);
    _descriptionNewsLabel.text = [descriptionText objectAtIndex:0];
    
//Clean the Description element to get Clean Image URL
    NSString * getURLfromDescription = self.newsInformation.DescriptionsNew;
    NSArray * urlImage = [getURLfromDescription componentsSeparatedByString:@"img src=\""];
    //NSLog(@"Half Clean Array ->%@", [urlImage objectAtIndex:1]);
    urlImage = [[urlImage objectAtIndex:1] componentsSeparatedByString:@"\" alt="];
    //NSLog(@"Another Half Clean Array ->%@", [urlImage objectAtIndex:0]);
    NSString * urlArtWork = [urlImage objectAtIndex:0];
    NSString * httpString = @"http:";
    urlArtWork = [httpString stringByAppendingString:urlArtWork];
    NSURL * url = [NSURL URLWithString:urlArtWork];
    NSLog(@"Clean Image URL->%@", url);
    NSData * imageData = [NSData dataWithContentsOfURL:url];
    self.imageNewURL.image=[[UIImage alloc]initWithData:imageData];
    
//Clean description to the the Original URL Web Site
    NSString * urlSite = self.newsInformation.DescriptionsNew;
//    NSLog(@"Full Description ->%@", self.newsInformation.DescriptionsNew);
    NSArray * cleanURLSite = [urlSite componentsSeparatedByString:@"url="];
    cleanURLSite = [[cleanURLSite objectAtIndex:1] componentsSeparatedByString:@"\"><img src"];
    NSLog(@"Clean Original Site ->%@", [cleanURLSite objectAtIndex:0]);
    _urlNewLabel.text = [cleanURLSite objectAtIndex:0];
    
    self.newsCleanURL = [[NSMutableArray alloc] init];
    
    self.newsCleanURL = [cleanURLSite objectAtIndex:0];
    
    NSLog(@" *******  Working with the URL *******");
    
    // For the view of the Lyrics I had to use a webView because the API for Wikia Lyrics page is  o longre Free.
    // Ir order to use the Copy Right for the Lyrics we need to pay.
    //I guess it wil be easer and it could look better if I could have the full JSON and manage it in a better way
    
    NSLog(@"News Details Segue ended");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Prepare for segue method
//This method prepares the data for the next view controller
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"This is the method for the News WebView Site");
    
    if ([[segue identifier] isEqualToString:@"NewsPageSegue"])
    {
        NewsWebViewController *controller = (NewsWebViewController *)segue.destinationViewController;
        controller.urlSiteWebView = self.newsCleanURL;
        
        NSLog(@"Clean URL for the Web View ->%@",controller.urlSiteWebView);
    }
}

- (IBAction)VIsitPageActionButton:(UIButton *)sender
{
    NSLog(@"Go to the News Page Button has beed pressed");
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
