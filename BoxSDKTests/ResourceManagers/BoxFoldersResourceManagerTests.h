//
//  BoxFoldersResourceManagerTests.h
//  BoxSDK
//
//  Created on 3/28/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <XCTest/XCTest.h>

@class BoxFoldersResourceManager;
@class BoxSerialOAuth2Session;
@class BoxSerialAPIQueueManager;

@interface BoxFoldersResourceManagerTests : XCTestCase
{
    BoxFoldersResourceManager *foldersManager;
    NSString *APIBaseURL;
    NSString *APIVersion;
    BoxSerialOAuth2Session *OAuth2Session;
    BoxSerialAPIQueueManager *queue;
    NSString *folderID;
}

@end
