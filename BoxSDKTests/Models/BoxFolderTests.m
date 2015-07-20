//
//  BoxFolderTests.m
//  BoxSDK
//
//  Created on 3/18/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import "BoxFolderTests.h"
#import "BoxSDKTestsHelpers.h"

#import "BoxCollection.h"
#import "BoxFolder.h"
#import "BoxUser.h"
#import "BoxSDKConstants.h"
#import "BoxFoldersResourceManager.h"


@implementation BoxFolderTests

- (void)setUp
{
    JSONDictionaryFull = @{
        BoxAPIObjectKeyType : BoxAPIItemTypeFolder,
        BoxAPIObjectKeyID : @"9000",
        BoxAPIObjectKeyCreatedAt : @"2009-03-04T01:02:03Z", // 1236128523
        BoxAPIObjectKeyModifiedAt : @"2009-03-05T01:02:03Z", // 1236214923
        BoxAPIObjectKeyContentCreatedAt : @"2009-03-01T01:02:03Z", // 1235869323
        BoxAPIObjectKeyContentModifiedAt : @"2009-03-02T01:02:03Z", // 1235955723
        BoxAPIObjectKeyTrashedAt : @"2009-03-02T01:02:03Z", // 1235955723
        BoxAPIObjectKeyPurgedAt : @"2009-03-02T01:02:03Z", // 1235955723
        BoxAPIObjectKeyDescription : @"Goku's Folder",
        BoxAPIObjectKeyName : @"Goku and his power level",
        BoxAPIObjectKeySize : @9001, // It's over 9000!
        BoxAPIObjectKeyETag : @"etag",
        BoxAPIObjectKeySequenceID : @"sequence-id",
        BoxAPIObjectKeyOwnedBy : @{
            BoxAPIObjectKeyType : @"user",
            BoxAPIObjectKeyID : @"1234"
        },
        BoxAPIObjectKeyCreatedBy : @{
            BoxAPIObjectKeyType : @"user",
            BoxAPIObjectKeyID : @"1235"
        },
        BoxAPIObjectKeyModifiedBy : @{
            BoxAPIObjectKeyType : @"user",
            BoxAPIObjectKeyID : @"1236"
        },
        BoxAPIObjectKeySharedLink : [NSNull null],
        BoxAPIObjectKeySyncState : @"synced",
        BoxAPIObjectKeyPathCollection : @{
            BoxAPICollectionKeyTotalCount : @1,
            BoxAPICollectionKeyEntries : @[
                @{
                    BoxAPIObjectKeyType : BoxAPIItemTypeFolder,
                    BoxAPIObjectKeyID : @"0",
                },
            ],
        },
        BoxAPIObjectKeyFolderUploadEmail : [NSNull null],
        BoxAPIObjectKeyItemStatus : @"active",
        BoxAPIObjectKeyParent : @{
                BoxAPIObjectKeyType : BoxAPIItemTypeFolder,
                BoxAPIObjectKeyID : BoxAPIFolderIDRoot,
            },
    };

    folder = [[BoxFolder alloc] initWithResponseJSON:JSONDictionaryFull mini:NO];

    // the minimum format returnable via ?fields
    JSONDictionaryMini = @{
        BoxAPIObjectKeyType : BoxAPIItemTypeFolder,
        BoxAPIObjectKeyID : @"9000",
    };

    miniFolder = [[BoxFolder alloc] initWithResponseJSON:JSONDictionaryMini mini:YES];

    // the minimum format returnable via ?fields
    JSONDictionaryRoot = @{
        BoxAPIObjectKeyType : BoxAPIItemTypeFolder,
        BoxAPIObjectKeyID : BoxAPIFolderIDRoot,
        BoxAPIObjectKeySequenceID : [NSNull null],
        BoxAPIObjectKeyETag : [NSNull null],
        BoxAPIObjectKeyCreatedAt : [NSNull null],
        BoxAPIObjectKeyModifiedAt : [NSNull null],
        BoxAPIObjectKeyTrashedAt : [NSNull null],
        BoxAPIObjectKeyPurgedAt : [NSNull null],
        BoxAPIObjectKeyContentCreatedAt : [NSNull null],
        BoxAPIObjectKeyContentModifiedAt : [NSNull null],
        BoxAPIObjectKeyParent : [NSNull null],
    };

    rootFolder = [[BoxFolder alloc] initWithResponseJSON:JSONDictionaryRoot mini:NO];
}

- (void)testThatCreatedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1236128523];
    XCTAssertEqualObjects(expectedDate, folder.createdAt, @"expected created at did not match actual");
}

- (void)testThatCreatedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.createdAt, @"created at should be nil");
}

- (void)testThatCreatedAtIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.createdAt, @"created at should be nil");
}

- (void)testThatCreatedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyCreatedAt : @"foobar is not a timestamp"} mini:YES];
    XCTAssertNil(garbageFolder.createdAt, @"created at should be nil when folder is initalized with a garbage value");
}

- (void)testThatModifiedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1236214923];
    XCTAssertEqualObjects(expectedDate, folder.modifiedAt, @"expected modified at did not match actual");
}

- (void)testThatModifiedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.modifiedAt, @"modified at should be nil");
}

- (void)testThatModifiedAtIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.modifiedAt, @"modified at should be nil");
}

- (void)testThatModifiedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyModifiedAt : @"foobar is not a timestamp"} mini:YES];
    XCTAssertNil(garbageFolder.modifiedAt, @"modified at should be nil when folder is initalized with a garbage value");
}

- (void)testThatContentCreatedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1235869323];
    XCTAssertEqualObjects(expectedDate, folder.contentCreatedAt, @"expected content created at did not match actual");
}

- (void)testThatContentCreatedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.contentCreatedAt, @"created at should be nil");
}

- (void)testThatContentCreatedAtIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.contentCreatedAt, @"content created at should be nil");
}

- (void)testThatContentCreatedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyContentCreatedAt : @"foobar is not a timestamp"} mini:YES];
    XCTAssertNil(garbageFolder.contentCreatedAt, @"content created at should be nil when folder is initalized with a garbage value");
}

- (void)testThatContentModifiedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1235955723];
    XCTAssertEqualObjects(expectedDate, folder.contentModifiedAt, @"expected content modified at did not match actual");
}

- (void)testThatContentModifiedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.contentModifiedAt, @"content modified at should be nil");
}

- (void)testThatContentModifiedAtIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.contentModifiedAt, @"content modified at should be nil");
}

- (void)testThatContentModifiedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyContentModifiedAt : @"foobar is not a timestamp"} mini:YES];
    XCTAssertNil(garbageFolder.contentModifiedAt, @"content modified at should be nil when folder is initalized with a garbage value");
}

- (void)testThatTrashedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1235955723];
    XCTAssertEqualObjects(expectedDate, folder.trashedAt, @"expected trashed at did not match actual");
}

- (void)testThatTrashedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.trashedAt, @"trashed at should be nil");
}

- (void)testThatTrashedAtIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.trashedAt, @"trashed at should be nil");
}

- (void)testThatTrashedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyTrashedAt : @"foobar is not a timestamp"} mini:YES];
    XCTAssertNil(garbageFolder.trashedAt, @"trashed at should be nil when folder is initalized with a garbage value");
}

- (void)testThatPurgedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1235955723];
    XCTAssertEqualObjects(expectedDate, folder.purgedAt, @"expected purged at did not match actual");
}

- (void)testThatPurgedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.purgedAt, @"purged at should be nil");
}

- (void)testThatPurgedAtIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.purgedAt, @"purged at should be nil");
}

- (void)testThatPurgedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyPurgedAt : @"foobar is not a timestamp"} mini:YES];
    XCTAssertNil(garbageFolder.purgedAt, @"purged at should be nil when folder is initalized with a garbage value");
}

- (void)testThatDescriptionIsReturnedFromFullFormat
{
    XCTAssertEqualObjects(@"Goku's Folder", folder.description, @"expected description did not match actual");
}

- (void)testThatDescriptionIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.description, @"expected description should be nil");
}

- (void)testThatDescriptionIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyDescription : @57} mini:YES];
    __unused NSString *description = nil;
    BoxAssertThrowsInDebugOrAssertNilInRelease(description = garbageFolder.description, @"description should be a string", @"description should be nil when folder is initalized with a garbage value");
}

- (void)testThatNameIsReturnedFromFullFormat
{
    XCTAssertEqualObjects(@"Goku and his power level", folder.name, @"expected name did not match actual");
}

- (void)testThatNameIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.name, @"expected name should be nil");
}

- (void)testThatNameIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyName : @57} mini:YES];
    __unused NSString *name = nil;
    BoxAssertThrowsInDebugOrAssertNilInRelease(name = garbageFolder.name, @"name should be a string", @"name should be nil when folder is initalized with a garbage value");
}

- (void)testThatSizeIsReturnedFromFullFormat
{
    XCTAssertEqualObjects(@9001, folder.size, @"expected size did not match actual");
}

- (void)testThatSizeIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.size, @"expected size should be nil");
}

- (void)testThatSizeIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeySize : @"not a size"} mini:YES];
    __unused NSNumber *size = nil;
    BoxAssertThrowsInDebugOrAssertNilInRelease(size = garbageFolder.size, @"size should be a number", @"size should be nil when folder is initalized with a garbage value");
}

- (void)testThatETagIsReturnedFromFullFormat
{
    XCTAssertEqualObjects(@"etag", folder.ETag, @"expected etag did not match actual");
}

- (void)testThatETagIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.ETag, @"expected etag should be nil");
}

- (void)testThatETagIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.ETag, @"ETag at should be nil");
}

- (void)testThatETagIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyETag : @57} mini:YES];
    __unused NSString *ETag = nil;
    BoxAssertThrowsInDebugOrAssertNilInRelease(ETag = garbageFolder.ETag, @"name should be a string", @"etag should be nil when folder is initalized with a garbage value");
}

- (void)testThatSequenceIDIsReturnedFromFullFormat
{
    XCTAssertEqualObjects(@"sequence-id", folder.sequenceID, @"expected sequence id did not match actual");
}

- (void)testThatSequenceIDIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.sequenceID, @"expected sequence id should be nil");
}

- (void)testThatSequenceIdIsReturnedAsNilIfNullInRootFolder
{
    XCTAssertNil(rootFolder.sequenceID, @"sequence id at should be nil");
}

- (void)testThatSequenceIDIsReturnedAsNilIfSetToAGarbageValue
{
    BoxFolder *garbageFolder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeySequenceID : @57} mini:YES];
    __unused NSString *sequenceID = nil;
    BoxAssertThrowsInDebugOrAssertNilInRelease(sequenceID = garbageFolder.sequenceID, @"sequence id should be a string", @"name should be nil when folder is initalized with a garbage value");
}

- (void)testThatCreatedByIsReturnedFromFullFormat
{
    XCTAssertTrue([folder.createdBy isKindOfClass:[BoxUser class]], @"expected created by to be a BoxUser");
}

- (void)testThatCreatedByIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.createdBy, @"expected created by should be nil");
}

- (void)testThatModifiedByIsReturnedFromFullFormat
{
    XCTAssertTrue([folder.modifiedBy isKindOfClass:[BoxUser class]], @"expected modified by to be a BoxUser");
}

- (void)testThatModifiedByIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.modifiedBy, @"expected modified by should be nil");
}

- (void)testThatOwnedByIsReturnedFromFullFormat
{
    XCTAssertTrue([folder.ownedBy isKindOfClass:[BoxUser class]], @"expected owned by to be a BoxUser");
}

- (void)testThatOwnedByIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.ownedBy, @"expected owned by should be nil");
}

- (void)testThatSharedLinkIsReturnedAsNullIfPresentAndUnsetInFullFormat
{
    XCTAssertEqualObjects([NSNull null], folder.sharedLink, @"expected shared link to be null object");
}

- (void)testThatSharedLinkIsReturnedAsNilIfUnsetInMiniFormat
{
    XCTAssertNil(miniFolder.sharedLink, @"expected shared link to be nil when unset");
}

- (void)testThatSyncStateIsReturnedFromFullFormat
{
    XCTAssertEqualObjects(@"synced", folder.syncState, @"expected sync state did not match actual");
}

- (void)testThatSyncStateIsReturnedAsNilIfUnsetInMiniFormat
{
    XCTAssertNil(miniFolder.syncState, @"expected sync state to be nil");
}

- (void)testThatPathCollectionIsReturnedFromFullFormat
{
    XCTAssertTrue([folder.pathCollection isKindOfClass:[BoxCollection class]], @"expected path collection to be a BoxCollection");
}

- (void)testThatPathCollectionIsReturnedAsNilIfUnsetFromMiniFormat
{
    XCTAssertNil(miniFolder.pathCollection, @"expected path collection should be nil");
}

- (void)testThatFolderUploadEmailIsReturnedAsNullIfPresentAndUnsetInFullFormat
{
    XCTAssertEqualObjects([NSNull null], folder.folderUploadEmail, @"expected folder upload email to be null object");
}

- (void)testThatFolderUploadEmailIsReturnedAsNilIfUnsetInMiniFormat
{
    XCTAssertNil(miniFolder.folderUploadEmail, @"expected folder upload email to be nil when unset");
}

- (void)testThatItemStatusIsReturnedFromFullFormat
{
    XCTAssertEqualObjects(@"active", folder.itemStatus, @"expected item status did not match actual");
}

- (void)testThatItemStatusIsReturnedAsNilIfUnsetInMiniFormat
{
    XCTAssertNil(miniFolder.itemStatus, @"expected item status to be nil");
}

- (void)testThatParentIsReturnedFromFullFormat
{
    XCTAssertNotNil(folder.parent, @"parent should be non-nil");
    XCTAssertTrue([folder.parent isKindOfClass:[BoxFolder class]], @"parent should be a BoxFolder");
}

- (void)testThatParentIsReturnedAsNilFromMiniFormat
{
    XCTAssertNil(miniFolder.parent, @"parent should be nil");
}

- (void)testThatParentIsReturnedAsNSNullFromRootFolder
{
    XCTAssertEqualObjects([NSNull null], rootFolder.parent, @"parent is nullable");
}

@end
