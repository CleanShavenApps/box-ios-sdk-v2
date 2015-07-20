//
//  BoxCommentsResourceManagerTests.h
//  BoxSDK
//
//  Created on 11/21/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <XCTest/XCTest.h>

@class BoxCommentsResourceManager;
@class BoxSerialOAuth2Session;
@class BoxSerialAPIQueueManager;

@interface BoxCommentsResourceManagerTests : XCTestCase
{
    BoxCommentsResourceManager *commentsManager;
    NSString *APIBaseURL;
    NSString *APIVersion;
    BoxSerialOAuth2Session *OAuth2Session;
    BoxSerialAPIQueueManager *queue;
    NSString *commentID;
}
@end
