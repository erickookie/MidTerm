//
//  NewFeedViewController.m
//  MidTerm
//
//  Created by MCS on 8/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "NewFeedViewController.h"
#import "News.h"
#import "Connection.h"
#import "JSONParsing.h"
#import "XMLParson.h"
#import "newsDetailViewController.h"
#import "DBManager.h"

@interface NewFeedViewController ()

@end

@implementation NewFeedViewController

#pragma mark - View Did Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"This is the super viewDidLoad for the NewFeedViewController");
    
    self.newsArray = [[NSMutableArray alloc ]init];
    
    DBManager * db = [[DBManager alloc]init];
    [db connectionDB];
    
    [self.tableView reloadData];
    
    // NSURLConnection
    Connection * con = [[Connection alloc] init];
    con.delegate = self;
    [con downloadFile];
    
//    [db insertQuery:@"Hello Insert"];
//    [db selectQuery:@"Hello select"];
//    self.SelectFromDBArray = [db selectQuery:@"Hello select"];
//    [db deleteQuery:@"Hello delete"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(Connection *)connection didFinishWithResultData:(NSData *)xmlData
{
//    NSLog(@"Entering the XMLParsing and JSONParsing");
    
    // XML Parsing
    XMLParsing * xmlParsing = [[XMLParsing alloc] initWithXMLData:xmlData];
    xmlParsing.delegate = self;
    [xmlParsing startParsing];
    
//  JSON Parsing
//    JSONParsing * jsonParsing = [[JSONParsing alloc] initWithData:xmlData];
//    jsonParsing.delegate = self;
//    [jsonParsing startParsing];
//    NSLog(@"End for the XML and JSON Parsing");
}

#pragma mark - XMLParsingDelegate

-(void)XMLParsing:(XMLParsing *)xmlParsing didFinishParsingWithResult:(NSArray *)resultArray
{
    
    DBManager * db = [[DBManager alloc]init];
    [db connectionDB];
    
    NSString * selectAll = [NSString stringWithFormat:@"SELECT * FROM favorites2"];
    
    NSMutableArray * favArray = [db selectQueryForTableView:selectAll];
    
    if (favArray == nil)
    {
        NSLog(@"Empty select");
    }
    else
    {
    NSLog(@"Elements from the fav table");


    for (int i=0; i<[favArray count]; i++)
    {
        NSString * fullRow = [favArray objectAtIndex:i];
        
       NSArray *listItems = [fullRow componentsSeparatedByString:@"#_#"];
        
        News * favElements = [[News alloc]init];
        
        NSString * titleString   = [NSString stringWithFormat:@"%@",[listItems objectAtIndex:0]];
        NSString * DescString    = [NSString stringWithFormat:@"%@",[listItems objectAtIndex:1]];
        NSString * urlNewString  = [NSString stringWithFormat:@"%@",[listItems objectAtIndex:2]];
        NSString * urlArtWork    = [NSString stringWithFormat:@"%@",[listItems objectAtIndex:3]];
        
        favElements.TitleNew = titleString;
        favElements.DescriptionsNew = DescString;
        favElements.urlNew = urlNewString;
        favElements.urlArtWork = urlArtWork;
        favElements.toogleStatus = YES;
        
        [self.newsArray addObject:favElements];
        NSLog(@"Favorites Elements added to the newArray");
    }
    }
//    NSLog(@"Set the XML to the resultArray");
    for (News *news in resultArray)
    {
//        NSLog(@"-------- New Item ----------- ");
//      NSLog(@"Title: %@", news.title);
        NSString * TitleNew = news.title;
//      NSLog(@"Description: %@", news.descriptionNew);
        NSString * DescriptionNew = news.descriptionNew;
//      NSLog(@"urWebView: %@", news.urlWebView);
        NSString * urlNew = news.urlWebView;
        
                 News * newElement = [[News alloc]init];
               newElement.TitleNew = TitleNew;
        
        //Clean the Full Description to get the Description, urlNew and the urlImage
        
        NSString * getDescription = news.descriptionNew;
        //NSLog(@"Full Description -> %@", getDescription);
        NSArray * descriptionText = [getDescription componentsSeparatedByString:@"<font size=\"-1\">"];
        descriptionText = [[descriptionText objectAtIndex:2] componentsSeparatedByString:@"<b>...</b>"];
        NSLog(@"Clean Description ->%@", [descriptionText objectAtIndex:0]);
        newElement.DescriptionsNew = [descriptionText objectAtIndex:0];
//        newElement.DescriptionsNew = DescriptionNew;
        
        
        NSString * urlSite = news.descriptionNew;
        //    NSLog(@"Full Description ->%@", self.newsInformation.DescriptionsNew);
        NSArray * cleanURLSite = [urlSite componentsSeparatedByString:@"url="];
        cleanURLSite = [[cleanURLSite objectAtIndex:1] componentsSeparatedByString:@"\"><img src"];
        NSLog(@"Clean Original Site ->%@", [cleanURLSite objectAtIndex:0]);
        newElement.urlNew = [cleanURLSite objectAtIndex:0];
//                 newElement.urlNew = urlNew;
        
        NSString * getURLfromDescription = news.descriptionNew;
        NSArray * urlImage = [getURLfromDescription componentsSeparatedByString:@"img src=\""];
        //NSLog(@"Half Clean Array ->%@", [urlImage objectAtIndex:1]);
        urlImage = [[urlImage objectAtIndex:1] componentsSeparatedByString:@"\" alt="];
        //NSLog(@"Another Half Clean Array ->%@", [urlImage objectAtIndex:0]);
        NSString * urlArtWork = [urlImage objectAtIndex:0];
        NSString * httpString = @"http:";
        urlArtWork = [httpString stringByAppendingString:urlArtWork];
        
        newElement.urlArtWork = urlArtWork;
        
           newElement.toogleStatus = NO;
        
//        NSLog(@"News Title -> %@", newElement.TitleNew);
        //NSLog(@"Desc News  -> %@", newElement.DescriptionsNew);
//        NSLog(@"URL Link   -> %@", newElement.urlNew);
        
        [self.newsArray addObject:newElement];
    }
    [self.tableView reloadData];
}

//#pragma mark - JSONParsingDelegate
//-(void) JSONParsing: (JSONParsing *)jsonParsing didFinishParsingWithResult: (NSDictionary *) resultDict
//{
//    NSLog(@"JSON Parsing");
//    NSLog(@"%@", resultDict);
//    
//    NSLog(@"End of the Dictionary Parsing");
//}

#pragma mark - TableView
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"Return the Number of segment for the Cell for the table View");
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"Table view return array count");
//    NSLog(@"Array Size -> %lu", (unsigned long)[self.newsArray count]);
    return [self.newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
// Normal Table view *********************************************************************************************************
    static NSString * simpleTableIdentifier = @"Cell";
    News * NewsRow = (News *)[self.newsArray objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UIButton *mimageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mimageButton.frame=CGRectMake(0, 0, 50, 50);
    mimageButton.tag = indexPath.row;
    // self.mimageButton.backgroundColor = [UIColor redColor];
    // [self.mimageButton addTarget:self action:@selector(favoriteButton:) forControlEvents: UIControlEventTouchUpInside];
    
    
    UIImageView *onButtonView = [[UIImageView alloc] initWithFrame:CGRectZero];
    onButtonView.tag = 100;
    
    if (!NewsRow.toogleStatus)
    {
        onButtonView.image = [UIImage imageNamed:@"iconUnselected.png"];
    }
    else
    {
        onButtonView.image = [UIImage imageNamed:@"iconSelected.png"];
    }
    
    [mimageButton setBackgroundImage:[onButtonView.image stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];

    [cell.contentView addSubview:mimageButton];
    [mimageButton addTarget:self action:@selector(changeMapType:) forControlEvents: UIControlEventTouchUpInside];
    
    UILabel* newsLabelText = [[UILabel alloc] init];
    newsLabelText.text = [NSString stringWithFormat:@"%@",NewsRow.TitleNew];
    
    CGRect labelFrame = CGRectInset(cell.contentView.bounds, 50, 10);
    labelFrame.size.width = cell.contentView.bounds.size.width / 2.0f;
    newsLabelText.font = [UIFont boldSystemFontOfSize:17.0f];
    newsLabelText.frame = labelFrame;
    newsLabelText.backgroundColor = [UIColor clearColor];
    cell.accessibilityLabel = [NSString stringWithFormat:@"%@",NewsRow.TitleNew];
    [cell.contentView addSubview:newsLabelText];
    
// Normal Table view *********************************************************************************************************
    
    return cell;
}

-(IBAction)favoriteButton:(id)sender
{
    NSLog(@"CAGADERO");
}

#pragma mark - Prepare for segue method
//This method prepares the data for the next view controller
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSLog(@"This is the method for the News Detailed");
    
    if ([segue.identifier isEqualToString:@"ShowNewsSegue"])
    {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        News* element=[self.newsArray objectAtIndex:indexPath.row];
        newsDetailViewController * newsDetailViewController = segue.destinationViewController;
        newsDetailViewController.newsInformation=element;
//        NSLog(@"Current New -> %@",element.TitleNew );
    }
}

-(void) switchChanged:(id)sender
{
    UISwitch* switcher = (UISwitch*)sender;
    BOOL value = switcher.on;
    NSLog(@"%@", value);
    // Store the value and/or respond appropriately
}

-(void)changeMapType:(id)sender
{
    UIButton *currentButton = ((UIImageView*)sender);
    self.changeimagetype = !self.changeimagetype;
    
    
    News * new = [self.newsArray objectAtIndex:currentButton.tag];
    if(new.toogleStatus == YES)
    {
        NSLog(@"Toggle Button Pressed -  Unselected tag:%ld", (long)currentButton.tag);
        [currentButton setBackgroundImage:[UIImage imageNamed:@"iconUnselected.png"] forState:UIControlStateNormal];
        new.toogleStatus = NO;
        NSLog(@"BUtton will delete the information from DB");
        
        NSLog(@"News Tittle -> %@", new.TitleNew);
//        NSLog(@"Description -> %@", new.DescriptionsNew);
//        NSLog(@"News urlImage -> %@", new.urlImage);
        NSString * titleNew = new.TitleNew;
        
    //Clean the URL image from the description
//        NSString * getURLfromDescription = new.DescriptionsNew;
//        NSArray * urlImage = [getURLfromDescription componentsSeparatedByString:@"img src=\""];
//        //NSLog(@"Half Clean Array ->%@", [urlImage objectAtIndex:1]);
//        urlImage = [[urlImage objectAtIndex:1] componentsSeparatedByString:@"\" alt="];
//        NSLog(@"%@", urlImage);
//        //NSLog(@"Another Half Clean Array ->%@", [urlImage objectAtIndex:0]);
//        NSString * urlArtWork = [urlImage objectAtIndex:0];
//        NSString * httpString = @"http:";
//        urlArtWork = [httpString stringByAppendingString:urlArtWork];
//        NSURL * url = [NSURL URLWithString:urlArtWork];
//        NSLog(@"News urlImage->%@", url);
//        
//        //Clean description to the the Original URL Web Site
//        NSString * urlSite = new.DescriptionsNew;
//        //    NSLog(@"Full Description ->%@", self.newsInformation.DescriptionsNew);
//        NSArray * cleanURLSite = [urlSite componentsSeparatedByString:@"url="];
//        cleanURLSite = [[cleanURLSite objectAtIndex:1] componentsSeparatedByString:@"\"><img src"];
//        NSLog(@"Original Site urlLink ->%@", [cleanURLSite objectAtIndex:0]);
        
        // Call the methods to delete the information to the DB
        
        DBManager * db = [[DBManager alloc]init];
        [db connectionDB];
        
        [db deleteQueryWithParamaters:titleNew];
    }
    else
    {
        NSLog(@"Toogle Button Pressed - Selected tag:%ld", (long)currentButton.tag);
        [currentButton setBackgroundImage:[UIImage imageNamed:@"iconSelected.png"] forState:UIControlStateNormal];
        new.toogleStatus = YES;
        NSLog(@"Button will add information to DB");
        
        NSLog(@"News Tittle -> %@", new.TitleNew);
//        NSLog(@"Description -> %@", new.DescriptionsNew);
//        NSLog(@"News urlImage -> %@", new.urlImage);
        NSString * titleNew = new.TitleNew;
        
    // Clean the Description from the News
        
        NSString * getDescription = new.DescriptionsNew;
//        //NSLog(@"Full Description -> %@", getDescription);
//        NSArray * descriptionText = [getDescription componentsSeparatedByString:@"<font size=\"-1\">"];
//        descriptionText = [[descriptionText objectAtIndex:2] componentsSeparatedByString:@"<b>...</b>"];
//        NSLog(@"Clean Description ->%@", [descriptionText objectAtIndex:0]);
////        NSString * descNew =  [NSString stringWithFormat:@"%@", [descriptionText objectAtIndex:0]];
        
        NSString * descNew =  new.DescriptionsNew;
        
    //Clean the URL image from the description
        NSString * getURLfromDescription = new.urlArtWork;
        
//        NSArray * urlImage = [getURLfromDescription componentsSeparatedByString:@"img src=\""];
//        //NSLog(@"Half Clean Array ->%@", [urlImage objectAtIndex:1]);
//        urlImage = [[urlImage objectAtIndex:1] componentsSeparatedByString:@"\" alt="];
//        //NSLog(@"Another Half Clean Array ->%@", [urlImage objectAtIndex:0]);
//        NSString * urlArtWork = [urlImage objectAtIndex:0];
//        NSString * httpString = @"http:";
//        urlArtWork = [httpString stringByAppendingString:urlArtWork];
//        NSURL * url = [NSURL URLWithString:urlArtWork];
//        NSLog(@"News urlImage->%@", url);
//        NSString * urlImageString = [url absoluteString];
        
        NSString * urlImageString =  getURLfromDescription;
        
//        [self getImageFromURL:urlImageString];

        
        
    //Clean description to the the Original URL Web Site
        
        NSString * urlSite = new.urlNew;
//        NSString * urlSite = new.DescriptionsNew;
//        //    NSLog(@"Full Description ->%@", self.newsInformation.DescriptionsNew);
//        NSArray * cleanURLSite = [urlSite componentsSeparatedByString:@"url="];
//        cleanURLSite = [[cleanURLSite objectAtIndex:1] componentsSeparatedByString:@"\"><img src"];
//        NSLog(@"Original Site urlLink ->%@", [cleanURLSite objectAtIndex:0]);
//        NSString * originalLinkString = [NSString stringWithFormat:@"%@", [cleanURLSite objectAtIndex:0]];
        
        NSString * originalLinkString = urlSite;
        
        //Call the Methods to insert the information into the DB
        

        DBManager * db = [[DBManager alloc]init];
        [db connectionDB];
        
        [db insertQueryWithParamaters:titleNew :descNew :urlImageString :originalLinkString];
        
//        NSMutableArray * favArray = [db selectQueryForTableView:titleNew];
        
        NSLog(@"Favorite Array ");
    }
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UIImage * imageFromURL = [self getImageFromURL:fileURL];
    [self saveImage:imageFromURL withFileName:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];
    
    return result;
}

-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

@end
