//
//  BoxFilesResourceManagerTests.h
//  BoxSDK
//
//  Created on 4/2/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <XCTest/XCTest.h>

@class BoxFilesResourceManager;
@class BoxSerialAPIQueueManager;
@class BoxSerialOAuth2Session;

@interface BoxFilesResourceManagerTests : XCTestCase
{
    BoxFilesResourceManager *filesManager;
    NSString *APIBaseURL;
    NSString *APIVersion;
    NSString *APIBaseUploadURL;
    NSString *APIUploadVersion;
    BoxSerialOAuth2Session *OAuth2Session;
    BoxSerialAPIQueueManager *queue;
    NSString *fileID;
}

@end
