//
//  BoxSharedObjectBuilderTests.m
//  BoxSDK
//
//  Created on 3/24/14.
//  Copyright (c) 2014 Box. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BoxSharedObjectBuilder.h"

@interface BoxSharedObjectBuilderTests : XCTestCase

@end

@implementation BoxSharedObjectBuilderTests

- (void)testThatAccessPermissionsAreProperlySet
{
    BoxSharedObjectBuilder *builder = [[BoxSharedObjectBuilder alloc] init];

    builder.access = BoxAPISharedObjectAccessOpen;
    XCTAssertEqualObjects(@"open", [builder bodyParameters][@"access"], @"Shared link access property is not set correctly");

    builder.access = BoxAPISharedObjectAccessCompany;
    XCTAssertEqualObjects(@"company", [builder bodyParameters][@"access"], @"Shared link access property is not set correctly");

    builder.access = BoxAPISharedObjectAccessCollaborators;
    XCTAssertEqualObjects(@"collaborators", [builder bodyParameters][@"access"], @"Shared link access property is not set correctly");
}

- (void)testThatPreviewPermissionsAreProperlySet
{
    BoxSharedObjectBuilder *builder = [[BoxSharedObjectBuilder alloc] init];

    NSArray *accessArray = [NSArray arrayWithObjects:BoxAPISharedObjectAccessOpen,
                                                    BoxAPISharedObjectAccessCompany,
                                                    BoxAPISharedObjectAccessCollaborators,
                                                    nil];

    for (BoxAPISharedObjectAccess *accessType in accessArray) {
        builder.access = accessType;

        builder.canPreview = BoxAPISharedObjectPermissionStateEnabled;
        XCTAssertTrue([[builder bodyParameters][@"permissions"][@"can_preview"] boolValue], @"Can preview failed to set correctly");

        builder.canPreview = BoxAPISharedObjectPermissionStateDisabled;
        XCTAssertFalse([[builder bodyParameters][@"permissions"][@"can_preview"] boolValue], @"Can preview failed to set correctly");

        builder.canPreview = BoxAPISharedObjectPermissionStateUnset;
        XCTAssertFalse([[builder bodyParameters][@"permissions"][@"can_preview"] boolValue], @"Can preview failed to set correctly");
    }
}

- (void)testThatDownloadPermissionsAreProperlySet
{
    BoxSharedObjectBuilder *builder = [[BoxSharedObjectBuilder alloc] init];

    NSArray *accessArray = [NSArray arrayWithObjects:BoxAPISharedObjectAccessOpen,
                            BoxAPISharedObjectAccessCompany,
                            BoxAPISharedObjectAccessCollaborators,
                            nil];

    for (BoxAPISharedObjectAccess *accessType in accessArray) {
        builder.access = accessType;

        builder.canDownload = BoxAPISharedObjectPermissionStateEnabled;
        XCTAssertTrue([[builder bodyParameters][@"permissions"][@"can_download"] boolValue], @"Can download failed to set correctly");

        builder.canDownload = BoxAPISharedObjectPermissionStateDisabled;
        XCTAssertFalse([[builder bodyParameters][@"permissions"][@"can_download"] boolValue], @"Can download failed to set correctly");

        builder.canDownload = BoxAPISharedObjectPermissionStateUnset;
        XCTAssertFalse([[builder bodyParameters][@"permissions"][@"can_download"] boolValue], @"Can download failed to set correctly");
    }
}


@end
