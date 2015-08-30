//
//  JSONParsing.h
//  MidTerm
//
//  Created by MCS on 8/27/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSONParsing;

@protocol JSONParsingDelegate <NSObject>

-(void) JSONParsing: (JSONParsing *)jsonParsing didFinishParsingWithResult: (NSDictionary *) resultDict;

@end

@interface JSONParsing : NSObject

@property (nonatomic, weak) id<JSONParsingDelegate> delegate;

- (instancetype)initWithData: (NSData *) jsonData;
- (void) startParsing;

@end
