//
//  DBManager.h
//  MidTerm
//
//  Created by MCS on 8/29/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@class DBManager;

@protocol DBManagerDelegate <NSObject>

@end

@interface DBManager : NSObject
//Private Variables here
{
//    sqlite3 * contactDB;
    sqlite3 * sqlite3DB;
}
@property (nonatomic, strong) NSString * databasePath;

@property (nonatomic, strong) NSMutableArray * selectQueryArray;

- (void) connectionDB;
- (void) insertQuery : (NSString *) StringQuery;
- (void) selectQuery : (NSString *) StringQuery;
- (void) deleteQuery : (NSString *) StringQuery;

-(void) insertQueryWithParamaters : (NSString *) titleNew : (NSString *) descNew : (NSString *) imageURL : (NSString *) origiginalLink;
- (void) selectQueryWithParamaters : (NSString *) titleNew;
- (void) deleteQueryWithParamaters : (NSString *) titleNew;
- (NSMutableArray *) selectQueryForTableView : (NSString *) titleNew;

@end
