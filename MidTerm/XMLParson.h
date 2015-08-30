//
//  XMLParson.h
//  MidTerm
//
//  Created by MCS on 8/27/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMLParsing;

@protocol XMLParsingDelegate <NSObject>

-(void) XMLParsing: (XMLParsing *)xmlParsing didFinishParsingWithResult:(NSArray *) resultArray;

@end

@interface XMLParsing : NSObject

@property (nonatomic, strong) id<XMLParsingDelegate> delegate;

- (instancetype)initWithXMLData: (NSData *) xmlData;
- (void) startParsing;

@end
