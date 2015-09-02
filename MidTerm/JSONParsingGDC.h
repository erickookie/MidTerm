//
//  JSONParsingGDC.h
//  MidTerm
//
//  Created by MCS on 8/31/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSONParsingGDC;

@protocol JSONParsingDelegate <NSObject>

-(void) JSONParsingGDC: (JSONParsingGDC *)jsonParsing didFinishParsingWithResult: (NSDictionary *) resultDict;

@end

@interface JSONParsingGDC : NSObject

@property (nonatomic, weak) id<JSONParsingDelegate> delegate;

- (instancetype)initWithData: (NSData *) jsonData;
- (void) startParsing;

@end
