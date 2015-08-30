//
//  Session.m
//  MidTerm
//
//  Created by MCS on 8/27/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "Session.h"

static NSString *const urlString = @"http://www.w3schools.com/xml/simple.xml";

@implementation Session

- (void) downloadFile
{
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    [session downloadTaskWithRequest:request];
}

#pragma mark - Delegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // When the file is downloaded to a specific location
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    // Executed when an error occurs
}

@end
