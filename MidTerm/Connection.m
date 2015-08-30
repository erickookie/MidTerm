//
//  Connection.m
//  MidTerm
//
//  Created by MCS on 8/27/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "Connection.h"

static NSString *const urlStringForXML1 = @"http://news.google.com/news?ned=us&topic=h&output=rss";
//static NSString *const urlStringForXML1 = @"https://news.google.com/news/section?ned=us&topic=h&output=rss.xml";
//static NSString *const urlStringForXML1 = @"http://www.w3schools.com/xml/simple.xml";

//static NSString *const urlStringForXML2 = @"http://news.google.com/news?cf=all&ned=us&hl=en&topic=h&output=rss";
//static NSString *const urlStringJSON = @"http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=8&q=http%3A%2F%2Fnews.google.com%2Fnews%3Foutput%3Drss";



@interface Connection()

@property (nonatomic, strong) NSMutableData *xmlData;

@end

@implementation Connection

#pragma mark - Connection DowloadFile
- (void) downloadFile
{
//    NSLog(@"Connection dowloadfile");
    self.xmlData = [[NSMutableData alloc] init];
    
    // For XML
    NSURL *url = [NSURL URLWithString:urlStringForXML1];
    
    
//    For JSON
//    NSURL * url = [NSURL URLWithString:urlStringJSON];
    
//    NSLog(@"Request to the URL ");
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url cachePolicy:1 timeoutInterval:3];
//    NSLog(@"Makes the connection with the request");
    NSURLConnection * con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Executed when the response is constructed.
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Executed when chunks of data are recieved
    [self.xmlData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Executed when the entire response is finished downloading
    [self.delegate connection:self didFinishWithResultData:self.xmlData];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Executed when the connection is terminated due to error.
    NSLog(@"Something is wrong, wait for the responce, I really appreciate your patience...");
    [self downloadFile];
}

@end
