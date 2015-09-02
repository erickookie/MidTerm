//
//  GDCImageViewController.m
//  MidTerm
//
//  Created by MCS on 8/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "GDCImageViewController.h"
#import "GDCConnection.h"
#import "JSONParsingGDC.h"
#import "Fuzz.h"
#import "RayWenderViewController.h"

@interface GDCImageViewController ()

@end

@implementation GDCImageViewController

- (void)viewDidLoad
{

    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"This is the super viewDidLoad for the GDCImageViewController");
    
      self.fuzzArray = [[NSMutableArray alloc]init];
      self.textArray = [[NSMutableArray alloc]init];
    self.imagesArray = [[NSMutableArray alloc]init];
     self.otherArray = [[NSMutableArray alloc]init];
    
    selectedSegment =  0;
    
    // NSURLConnection
    GDCConnection * con = [[GDCConnection alloc] init];
    con.delegate = self;
    [con downloadFile];
    
    [super viewDidLoad];
}

-(void)GDCConnection:(GDCConnection *)GDCConnection didFinishWithResultData:(NSData *)xmlData
{
    //  JSON Parsing
    //NSLog(@"Call connection Method with JSON Parameters");
    JSONParsingGDC * jsonParsing = [[JSONParsingGDC alloc] initWithData:xmlData];
    jsonParsing.delegate = self;
    [jsonParsing startParsing];
    NSLog(@"End for the XML and JSON Parsing");
}

#pragma mark - JSONParsingDelegate
-(void) JSONParsingGDC: (JSONParsingGDC *)jsonParsing didFinishParsingWithResult: (NSMutableArray *) resultDict
{
    NSLog(@"JSON Parsing for GDC ");
//    NSLog(@"%@", resultDict);
    
    NSDictionary * dictionaryFromParse = resultDict;
    
    NSArray * fuzzArray = resultDict;
    //NSLog(@"Array -> %@", artistArray);
    NSLog(@"Elements from Dictionary -> %lu", [fuzzArray count]);
    
    for (NSDictionary * fuzzInfo in fuzzArray)
    {
        NSString * data = [fuzzInfo objectForKey:@"data"];
        NSString * date = [fuzzInfo objectForKey:@"date"];
        NSString * idNo = [fuzzInfo objectForKey:@"id"];
        NSString * type = [fuzzInfo objectForKey:@"type"];
        
//        NSLog(@"**** New Element ***");
//        
//        NSLog(@"Data -> %@", data);
//        NSLog(@"Date -> %@", date);
//        NSLog(@"idNo -> %@", idNo);
//        NSLog(@"Type -> %@", type);
//        
//        NSLog(@"*** **** **** ");
        
        Fuzz * newElement = [[Fuzz alloc]init];
        
        newElement.data = data;
        newElement.date = date;
        newElement.idNo = idNo;
        newElement.type = type;
        
        if ([newElement.type  isEqual: @"text"])
        {
            NSLog(@"Element -> Text");
            [self.textArray addObject:newElement];
        }
        else if ([newElement.type  isEqual: @"image"])
        {
            NSLog(@"Element -> image");
            [self.imagesArray addObject:newElement];
        }
        else if ([newElement.type  isEqual: @"other"])
        {
            NSLog(@"Element -> other");
            [self.otherArray addObject:newElement];
        }
        [self.fuzzArray addObject:newElement];
    }
    [self.tableView reloadData];
}

#pragma mark - TableView
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Selected Segment -> %d", selectedSegment);
    
    NSLog(@"Table view return array count");
    NSLog(@"Array Size -> %lu", (unsigned long)[self.fuzzArray count]);
    return [self.fuzzArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"///////////////////////////////////////////////////");
    NSLog(@"Selected Segment in the table view-> %d", selectedSegment);
    NSLog(@"Goes inside of the tableview");
    
    static NSString * simpleTableIdentifier = @"fuzzCell";
    NSLog(@"-----------Fuzzy Array-------");
    NSLog(@"%@", self.fuzzArray);
    NSLog(@"-----------Text Array-------");
    NSLog(@"%@", self.textArray);
    NSLog(@"-----------Image Array-------");
    NSLog(@"%@", self.imagesArray);
    NSLog(@"-----------Other Array-------");
    NSLog(@"%@", self.otherArray);
    
    Fuzz * item;
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (selectedSegment == 0)
    {
        NSLog(@"Cell Full of text and images");
       item = (Fuzz *)[self.fuzzArray objectAtIndex:indexPath.row];
        
        NSString * urlString = [NSString stringWithFormat:@"%@",item.data];
        
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        cell.imageView.image = [UIImage imageWithData:imageData];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",item.data];
    }
    
    else if (selectedSegment == 1)
    {
        NSLog(@"Cell Full of text");
        item = (Fuzz *)[self.textArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",item.data];
    }
    
    else if (selectedSegment == 2)
    {
        NSLog(@"Cell Full of images");
        item = (Fuzz *)[self.imagesArray objectAtIndex:indexPath.row];
        
        NSString * urlString = [NSString stringWithFormat:@"%@",item.data];
        
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        cell.imageView.image = [UIImage imageWithData:imageData];
    }
    
    else if (selectedSegment == 3)
    {
        NSLog(@"Cell Full of other things");
        item = (Fuzz *)[self.otherArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (IBAction)indexSelector:(UISegmentedControl *)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"0 -> All selected");
            selectedSegment = 0;
            [self.tableView reloadData];
            break;
        case 1:
            NSLog(@" -> Text selected");
            selectedSegment = 1;
            [self.tableView reloadData];
            break;
        case 2:
            NSLog(@" -> Images Selected");
            selectedSegment = 2;
            [self.tableView reloadData];
            break;
            
        case 3:
            NSLog(@" -> Other Selected");
            selectedSegment = 3;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - Prepare for segue method
//This method prepares the data for the next view controller
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    NSLog(@"This is the method for the News Detailed");
    
    if ([segue.identifier isEqualToString:@"raySegue"])
    {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        Fuzz* element=[self.rayArray objectAtIndex:indexPath.row];
        RayWenderViewController * RayWenderViewController = segue.destinationViewController;
        RayWenderViewController.newsInformation=element;
        //        NSLog(@"Current New -> %@",element.TitleNew );
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
