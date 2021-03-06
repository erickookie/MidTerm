//
//  JSONParsingGDC.m
//  MidTerm
//
//  Created by MCS on 8/31/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "JSONParsingGDC.h"

@interface JSONParsingGDC ()

@property (nonatomic, strong) NSData *jsonData;

@end

@implementation JSONParsingGDC

- (instancetype)initWithData: (NSData *) jsonData
{
    NSLog(@"Init With Data JSON");
    self = [super init];
    if (self)
    {
        _jsonData = jsonData;
    }
    return self;
}

- (void) startParsing
{
    NSLog(@"Start Parsing JSON");
    NSError *error;
    
    NSObject *obj;
    
    // Check if the object is of a specific subclass.
    if ([obj isKindOfClass:[NSDictionary class]])
    {
    }
    
    NSLog(@"NSJSON Reading arguments");
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Dictionary Created");
    
    NSLog(@"Dictionary -> %lu",(unsigned long)[resultDictionary count]);
    
    
    if (!error)
    {
        [self.delegate JSONParsingGDC:self didFinishParsingWithResult:resultDictionary];
    }
    else NSLog(@"Error in smomething");
    NSLog(@"JSONParsing Ended");
}

@end
