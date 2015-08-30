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
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",NewsRow.TitleNew,NewsRow.DescriptionsNew];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",NewsRow.TitleNew];
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

@end
