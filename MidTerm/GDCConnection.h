//
//  GDCConnection.h
//  MidTerm
//
//  Created by MCS on 8/31/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDCConnection;

@protocol ConnectionDelegate <NSObject>

- (void) GDCConnection: (GDCConnection *) connection didFinishWithResultData: (NSData *) resultData;

@end

@interface GDCConnection : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) id<ConnectionDelegate> delegate;

- (void) downloadFile;

@end
