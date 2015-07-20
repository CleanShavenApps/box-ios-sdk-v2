//
//  BoxFolderTests.h
//  BoxSDK
//
//  Created on 3/18/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BoxFolder.h"

@interface BoxFolderTests : XCTestCase
{
    NSDictionary *JSONDictionaryFull;
    NSDictionary *JSONDictionaryMini;
    NSDictionary *JSONDictionaryRoot;
    BoxFolder *folder;
    BoxFolder *miniFolder;
    // The root folder is special and has keys that are not normally nullable
    BoxFolder *rootFolder;
}

@end
