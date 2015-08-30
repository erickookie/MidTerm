//
//  DBManager.h
//  MidTerm
//
//  Created by MCS on 8/29/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBManager

@protocol DBManagerDelegate <NSObject>

@end

@interface DBManager : NSObject

- (void) connectionDB;
- (void) insertQuery;
- (void) selectQuery;
- (void) deleteQuery;

@end
