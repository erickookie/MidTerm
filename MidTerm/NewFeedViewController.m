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
    
    // NSURLConnection
    Connection * con = [[Connection alloc] init];
    con.delegate = self;
    [con downloadFile];
    
    DBManager * db = [[DBManager alloc]init];
    [db connectionDB];
    
//    [db insertQuery:@"Hello Insert"];
    
    [db selectQuery:@"Hello select"];
    
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
        newElement.DescriptionsNew = DescriptionNew;
                 newElement.urlNew = urlNew;
        
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
    static NSString * simpleTableIdentifier = @"Cell";
    News * NewsRow = (News *)[self.newsArray objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    self.mimageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mimageButton.frame=CGRectMake(0, 0, 50, 50);
    self.mimageButton.tag = 1;
    
    self.onButtonView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.onButtonView.tag = 2;
    self.onButtonView.image = [UIImage imageNamed:@"iconUnselected.png"];
    [self.mimageButton setBackgroundImage:[self.onButtonView.image stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [cell.contentView addSubview:self.mimageButton];
    [self.mimageButton addTarget:self action:@selector(changeMapType:) forControlEvents: UIControlEventTouchUpInside];
    
    UILabel* newsLabelText = [[UILabel alloc] init];
    newsLabelText.text = [NSString stringWithFormat:@"%@",NewsRow.TitleNew];
    
    
    
    CGRect labelFrame = CGRectInset(cell.contentView.bounds, 50, 10);
    labelFrame.size.width = cell.contentView.bounds.size.width / 2.0f;
    newsLabelText.font = [UIFont boldSystemFontOfSize:17.0f];
    newsLabelText.frame = labelFrame;
    newsLabelText.backgroundColor = [UIColor clearColor];
    cell.accessibilityLabel = [NSString stringWithFormat:@"%@",NewsRow.TitleNew];
    [cell.contentView addSubview:newsLabelText];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",NewsRow.TitleNew];
    
    return cell;
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

-(void) switchChanged:(id)sender {
    UISwitch* switcher = (UISwitch*)sender;
    BOOL value = switcher.on;
    // Store the value and/or respond appropriately
}

-(void)changeMapType:(id)sender
{
    self.changeimagetype = !self.changeimagetype;
    
    if(self.changeimagetype == YES)
    {
        NSLog(@"Toggle Button Pressed -  Unselected");
        //[typechange setImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];
        //self.myGreatMapView.mapType = MKMapTypeStandard;
        self.onButtonView.image = [UIImage imageNamed:@"iconUnselected.png"];
        [self.mimageButton setImage:self.onButtonView.image forState:UIControlStateNormal];
        //someBarButtonItem.image = [UIImage imageNamed:@"alarm_ON..png"];
        //changeimagetype =NO;
    }
    else
    {
        NSLog(@"Toogle Button Pressed - Selected");
        //self.myGreatMapView.mapType = MKMapTypeSatellite;
        self.onButtonView.image = [UIImage imageNamed:@"iconSelected.png"];
        [self.mimageButton setImage:self.onButtonView.image forState:UIControlStateNormal];
    }
    
}

@end
