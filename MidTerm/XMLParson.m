//
//  XMLParson.m
//  MidTerm
//
//  Created by MCS on 8/27/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "XMLParson.h"
#import "News.h"

static NSString *const newsEntity = @"item";
static NSString *const titleTag = @"title";
static NSString *const descriptionTag = @"description";
static NSString *const urlWebView = @"link";

@interface XMLParsing () <NSXMLParserDelegate>

@property (nonatomic, strong) NSData *xmlData;

@property (nonatomic, strong) NSMutableArray * NewsArray;
@property (nonatomic, strong) News *news;

@property (nonatomic, assign) BOOL isTitleProperty;
@property (nonatomic, assign) BOOL isDescriptionProperty;
@property (nonatomic, assign) BOOL isURLWebView;

@end

@implementation XMLParsing

- (instancetype)initWithXMLData: (NSData *) xmlData
{
//    NSLog(@"Init With Data XML");
    self = [super init];
    if (self)
    {
        _xmlData = xmlData;
        _NewsArray = [[NSMutableArray alloc] initWithCapacity:3];
        _isTitleProperty = NO;
        _isDescriptionProperty = NO;
        _isURLWebView = NO;
    }
    return self;
}

-(void)startParsing
{
//    NSLog(@"Start Parsing XML");
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.xmlData];
    parser.delegate = self;
    [parser parse];
}



#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:newsEntity])
    {
        self.news = [[News alloc] init];
        self.news.descriptionNew = @"";
    }else if ([elementName isEqualToString:titleTag])
    {
        self.isTitleProperty = YES;
    }else if ([elementName isEqualToString:descriptionTag])
    {
        self.isDescriptionProperty = YES;
    }else if ([elementName isEqualToString:urlWebView])
    {
        self.isURLWebView = YES;
    }
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.isTitleProperty)
    {
        self.news.title = string;
    }else if (self.isDescriptionProperty)
    {
        self.news.descriptionNew = [self.news.descriptionNew stringByAppendingString:string];
    }else if (self.isURLWebView)
    {
        self.news.urlWebView = string;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:newsEntity])
    {
        [self.NewsArray addObject:self.news];
    }else if ([elementName isEqualToString:titleTag])
    {
        self.isTitleProperty = NO;
    }else if ([elementName isEqualToString:descriptionTag])
    {
        self.isDescriptionProperty = NO;
    }else if ([elementName isEqualToString:urlWebView])
    {
        self.isURLWebView = NO;
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.delegate XMLParsing:self didFinishParsingWithResult:self.NewsArray];
}

@end