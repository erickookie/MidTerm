//
//  Session.h
//  MidTerm
//
//  Created by MCS on 8/27/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject <NSURLSessionDownloadDelegate>

- (void) downloadFile;

@end
