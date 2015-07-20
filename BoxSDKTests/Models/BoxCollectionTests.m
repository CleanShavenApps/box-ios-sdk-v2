//
//  BoxCollectionTests.m
//  BoxSDK
//
//  Created on 3/18/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import "BoxCollectionTests.h"

#import "BoxSDKConstants.h"
#import "BoxModel.h"
#import "BoxFile.h"
#import "BoxFolder.h"
#import "BoxWebLink.h"

#define COLLECTION_TOTAL_COUNT (@50)
#define COLLECTION_PAGE_ITEM_COUNT (5U)

@implementation BoxCollectionTests

- (void)setUp
{
    JSONDictionary = @{
        BoxAPICollectionKeyTotalCount : COLLECTION_TOTAL_COUNT,
        BoxAPICollectionKeyEntries : @[
            @{
                BoxAPIObjectKeyType : BoxAPIItemTypeFile,
                BoxAPIObjectKeyID : @"1234",
            },
            @{
                BoxAPIObjectKeyType : BoxAPIItemTypeFolder,
                BoxAPIObjectKeyID : @"1235",
            },
            @{
                BoxAPIObjectKeyType : BoxAPIItemTypeWebLink,
                BoxAPIObjectKeyID : @"1236",
            },
            @{
                BoxAPIObjectKeyType : BoxAPIItemTypeFile,
                BoxAPIObjectKeyID : @"1237",
            },
            @{
                BoxAPIObjectKeyType : BoxAPIItemTypeWebLink,
                BoxAPIObjectKeyID : @"1238",
                },
        ],
    };

    collection = [[BoxCollection alloc] initWithResponseJSON:JSONDictionary mini:YES];
}

- (void)testThatCollectionReturnsCorrectTotalCount
{
    XCTAssertEqualObjects(COLLECTION_TOTAL_COUNT, collection.totalCount, @"Expected total count does not match");
}

- (void)testThatCollectionReturnsTotalItemsInPageItRepresents
{
    XCTAssertEqual((NSUInteger)COLLECTION_PAGE_ITEM_COUNT, collection.numberOfEntries, @"collection returned incorrect number of entries");
}

- (void)testThatCollectionReturnsABoxFileForEntryZero
{
    BoxModel *item = [collection modelAtIndex:0];
    XCTAssertNotNil(item, @"item is not nil");
    XCTAssertTrue([item isKindOfClass:[BoxFile class]], @"BoxModel should be a BoxFile");
}

- (void)testThatCollectionReturnsABoxFolderForEntryOne
{
    BoxModel *item = [collection modelAtIndex:1];
    XCTAssertNotNil(item, @"item is not nil");
    XCTAssertTrue([item isKindOfClass:[BoxFolder class]], @"BoxModel should be a BoxFolder");
}

- (void)testThatCollectionReturnsABoxWebLinkForEntryFour
{
    BoxModel *item = [collection modelAtIndex:4];
    XCTAssertNotNil(item, @"item is not nil");
    XCTAssertTrue([item isKindOfClass:[BoxWebLink class]], @"BoxModel should be a BoxWebLink");
}

@end
