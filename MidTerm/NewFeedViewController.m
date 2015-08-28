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

@interface NewFeedViewController ()

@end

@implementation NewFeedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"This is the super viewDidLoad for the NewFeedViewController");
    
    // NSURLConnection
    Connection * con = [[Connection alloc] init];
    con.delegate = self;
    [con downloadFile];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(Connection *)connection didFinishWithResultData:(NSData *)xmlData
{
    NSLog(@"Entering the XMLParsing and JSONParsing");
    
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
    NSLog(@"Set the XML to the resultArray");
    for (News *news in resultArray)
    {
        NSLog(@"-------- New Item ----------- ");
        NSLog(@"Title: %@", news.title);
        NSLog(@"Description: %@", news.descriptionNew);
        NSLog(@"urWebView: %@", news.urlWebView);
    }
    
}

//#pragma mark - JSONParsingDelegate
//-(void) JSONParsing: (JSONParsing *)jsonParsing didFinishParsingWithResult: (NSDictionary *) resultDict
//{
//    NSLog(@"JSON Parsing");
//    NSLog(@"%@", resultDict);
//    
//    NSLog(@"End of the Dictionary Parsing");
//}

//#pragma mark - TableView
//
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"Return the Number of segment for the Cell for the table View");
    return 1;
}
//
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"Table view return array count");
//    NSLog(@"Array Size -> %lu", (unsigned long)[self.allEntries count]);
//    return [self.allEntries count];
    return 0;
}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
//    }
//    
//    RSSEntry *entry = [_allEntries objectAtIndex:indexPath.row];
//    
//    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
//    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    NSString *articleDateString = [dateFormatter stringFromDate:entry.articleDate];
//    
//    cell.textLabel.text = entry.articleTitle;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", articleDateString, entry.blogTitle];
//    
//    return cell;
//}
//
//- (void)refresh
//{
//    for (NSString *feed in _feeds)
//    {
//        NSURL *url = [NSURL URLWithString:feed];
////        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        [request setDelegate:self];
//        [_queue addOperation:request];
//    }
//}

//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    
//    RSSEntry *entry = [[RSSEntry alloc] initWithBlogTitle:request.url.absoluteString
//                                              articleTitle:request.url.absoluteString
//                                                articleUrl:request.url.absoluteString
//                                               articleDate:[NSDate date]];
//    int insertIdx = 0;
//    [_allEntries insertObject:entry atIndex:insertIdx];
//    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIdx inSection:0]]
//                          withRowAnimation:UITableViewRowAnimationRight];
//    
//}

//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSError *error = [request error];
//    NSLog(@"Error: %@", error);
//}

@end
