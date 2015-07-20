//
//  BoxModelComparatorsTest.m
//  BoxSDK
//
//  Created on 8/4/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import "BoxModelComparatorsTest.h"

#import "BoxModelComparators.h"
#import "BoxModel.h"
#import "BoxFile.h"
#import "BoxFolder.h"
#import "BoxWebLink.h"
#import "BoxSDKConstants.h"

@implementation BoxModelComparatorsTest

#pragma mark - modelByTypeAndID

- (void)testThatBoxFilePreceedsBoxFolder
{
    BoxFile *file = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345"} mini:YES];
    BoxFolder *folder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345"} mini:YES];

    NSComparisonResult result = [file compare:folder usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedAscending, result, @"Expected order: file,folder");
}

- (void)testThatBoxFolderSucceedsBoxFile
{
    BoxFile *file = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345"} mini:YES];
    BoxFolder *folder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345"} mini:YES];

    NSComparisonResult result = [folder compare:file usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedDescending, result, @"Expected order: file,folder");
}

- (void)testThatBoxFilePreceedsBoxWebLink
{
    BoxFile *file = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345"} mini:YES];
    BoxWebLink *weblink = [[BoxWebLink alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeWebLink, BoxAPIObjectKeyID : @"12345"} mini:YES];

    NSComparisonResult result = [file compare:weblink usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedAscending, result, @"Expected order: file,weblink");
}

- (void)testThatBoxWebLinkSucceedsBoxFile
{
    BoxFile *file = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345"} mini:YES];
    BoxWebLink *weblink = [[BoxWebLink alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeWebLink, BoxAPIObjectKeyID : @"12345"} mini:YES];

    NSComparisonResult result = [weblink compare:file usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedDescending, result, @"Expected order: file,weblink");
}

- (void)testThatBoxFolderPreceedsBoxWebLink
{
    BoxFolder *folder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345"} mini:YES];
    BoxWebLink *weblink = [[BoxWebLink alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeWebLink, BoxAPIObjectKeyID : @"12345"} mini:YES];

    NSComparisonResult result = [folder compare:weblink usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedAscending, result, @"Expected order: folder,weblink");
}

- (void)testThatBoxWebLinkSucceedsBoxFolder
{
    BoxFolder *folder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345"} mini:YES];
    BoxWebLink *weblink = [[BoxWebLink alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeWebLink, BoxAPIObjectKeyID : @"12345"} mini:YES];

    NSComparisonResult result = [weblink compare:folder usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedDescending, result, @"Expected order: folder,weblink");
}

- (void)testThatBoxFolderWithID99PreceedsBoxFolderWithID123
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"99"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"123"} mini:YES];

    NSComparisonResult result = [folder1 compare:folder2 usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedAscending, result, @"Expected order: folder1,folder2");
}

- (void)testThatBoxFolderWithID123SucceedsBoxFolderWithID999
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"99"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"123"} mini:YES];

    NSComparisonResult result = [folder2 compare:folder1 usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedDescending, result, @"Expected order: folder1,folder2");
}

- (void)testThatBoxFoldersWithEqualIDsAreNSOrderedSame
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"9001"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"9001"} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedSame, result1, @"Expected order: folder1 == folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators modelByTypeAndID]];
    XCTAssertEqual(NSOrderedSame, result2, @"Expected order: folder1 == folder2");
}

#pragma mark - itemByName

- (void)testThatItemsWithDifferentTypesAndSameNameAreNSOrderedSame
{
    BoxFolder *folder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyName: @"same name"} mini:YES];
    BoxWebLink *weblink = [[BoxWebLink alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeWebLink, BoxAPIObjectKeyID : @"99999", BoxAPIObjectKeyName: @"same name"} mini:YES];

    NSComparisonResult result1 = [folder compare:weblink usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedSame, result1, @"Expected order: folder == weblink");
    NSComparisonResult result2 = [weblink compare:folder usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedSame, result2, @"Expected order: folder == weblink");
}

- (void)testDifferentNamesAreOrderedAlphabetically
{
    BoxFolder *folder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyName: @"ABC"} mini:YES];
    BoxWebLink *weblink = [[BoxWebLink alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeWebLink, BoxAPIObjectKeyID : @"99999", BoxAPIObjectKeyName: @"XYZ"} mini:YES];

    NSComparisonResult result1 = [folder compare:weblink usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedAscending, result1, @"Expected order: folder,weblink");
    NSComparisonResult result2 = [weblink compare:folder usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedDescending, result2, @"Expected order: folder,weblink");
}

- (void)testCaseMattersWhenOrderingByName
{
    BoxFolder *folder = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyName: @"ABC"} mini:YES];
    BoxWebLink *weblink = [[BoxWebLink alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeWebLink, BoxAPIObjectKeyID : @"99999", BoxAPIObjectKeyName: @"abc"} mini:YES];

    NSComparisonResult result1 = [folder compare:weblink usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedAscending, result1, @"Expected order: folder,weblink");
    NSComparisonResult result2 = [weblink compare:folder usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedDescending, result2, @"Expected order: folder,weblink");
}

- (void)testOriginalPreceedsCopy
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyName: @"ABC"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyName: @"ABC (1)"} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedAscending, result1, @"Expected order: folder1,folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedDescending, result2, @"Expected order: folder1,folder2");
}

- (void)testCopiesAreOrderedNumerically
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyName: @"ABC (2)"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyName: @"ABC (10)"} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedAscending, result1, @"Expected order: folder1,folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemByName]];
    XCTAssertEqual(NSOrderedDescending, result2, @"Expected order: folder1,folder2");
}

#pragma mark - itemByCreatedAt

- (void)testDifferentCreatedDatesAreOrderedCorrectly
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyCreatedAt: @"2000-01-01T00:00:00"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyCreatedAt: @"2010-01-01T00:00:00"} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemByCreatedAt]];
    XCTAssertEqual(NSOrderedAscending, result1, @"Expected order: folder1,folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemByCreatedAt]];
    XCTAssertEqual(NSOrderedDescending, result2, @"Expected order: folder1,folder2");
}

- (void)testSameCreatedDatesReturnNSOrderedSame
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyCreatedAt: @"2000-01-01T00:00:00"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyCreatedAt: @"2000-01-01T00:00:00"} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemByCreatedAt]];
    XCTAssertEqual(NSOrderedSame, result1, @"Expected order: folder1 == folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemByCreatedAt]];
    XCTAssertEqual(NSOrderedSame, result2, @"Expected order: folder1 == folder2");
}

#pragma mark - itemByModifiedAt

- (void)testDifferentModifiedDatesAreOrderedCorrectly
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyModifiedAt: @"2000-01-01T00:00:00"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyModifiedAt: @"2010-01-01T00:00:00"} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemByModifiedAt]];
    XCTAssertEqual(NSOrderedAscending, result1, @"Expected order: folder1,folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemByModifiedAt]];
    XCTAssertEqual(NSOrderedDescending, result2, @"Expected order: folder1,folder2");
}

- (void)testSameModifiedDatesReturnNSOrderedSame
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyModifiedAt: @"2000-01-01T00:00:00"} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeyModifiedAt: @"2000-01-01T00:00:00"} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemByModifiedAt]];
    XCTAssertEqual(NSOrderedSame, result1, @"Expected order: folder1 == folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemByModifiedAt]];
    XCTAssertEqual(NSOrderedSame, result2, @"Expected order: folder1 == folder2");
}

#pragma mark - itemBySize

- (void)testDifferentSizesAreOrderedCorrectly
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySize: @99} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySize: @1024} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemBySize]];
    XCTAssertEqual(NSOrderedAscending, result1, @"Expected order: folder1,folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemBySize]];
    XCTAssertEqual(NSOrderedDescending, result2, @"Expected order: folder1,folder2");
}

- (void)testSameSizesReturnNSOrderedSame
{
    BoxFolder *folder1 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySize: @1024} mini:YES];
    BoxFolder *folder2 = [[BoxFolder alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFolder, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySize: @1024} mini:YES];

    NSComparisonResult result1 = [folder1 compare:folder2 usingComparator:[BoxModelComparators itemBySize]];
    XCTAssertEqual(NSOrderedSame, result1, @"Expected order: folder1 == folder2");
    NSComparisonResult result2 = [folder2 compare:folder1 usingComparator:[BoxModelComparators itemBySize]];
    XCTAssertEqual(NSOrderedSame, result2, @"Expected order: folder1 == folder2");
}

#pragma mark - fileBySHA1

- (void)testDifferentSHA1sAreNotEqual
{
    BoxFile *file1 = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySHA1: @"deadbeef"} mini:YES];
    BoxFile *file2 = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySHA1: @"feedbeef"} mini:YES];

    NSComparisonResult result1 = [file1 compare:file2 usingComparator:[BoxModelComparators fileBySHA1]];
    XCTAssertTrue(NSOrderedSame != result1, @"file1 != file2");
    NSComparisonResult result2 = [file2 compare:file1 usingComparator:[BoxModelComparators fileBySHA1]];
    XCTAssertTrue(NSOrderedSame != result2, @"file1 != file2");
}

- (void)testSameSHA1sReturnNSOrderedSame
{
    BoxFile *file1 = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySHA1: @"deadbeef"} mini:YES];
    BoxFile *file2 = [[BoxFile alloc] initWithResponseJSON:@{BoxAPIObjectKeyType : BoxAPIItemTypeFile, BoxAPIObjectKeyID : @"12345", BoxAPIObjectKeySHA1: @"deadbeef"} mini:YES];

    NSComparisonResult result1 = [file1 compare:file2 usingComparator:[BoxModelComparators fileBySHA1]];
    XCTAssertEqual(NSOrderedSame, result1, @"Expected order: file1 == file2");
    NSComparisonResult result2 = [file2 compare:file1 usingComparator:[BoxModelComparators fileBySHA1]];
    XCTAssertEqual(NSOrderedSame, result2, @"Expected order: file1 == file2");
}

@end
