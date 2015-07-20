//
//  BoxFileTests.h
//  BoxSDK
//
//  Created on 3/22/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BoxFile.h"

@interface BoxFileTests : XCTestCase
{
    NSDictionary *JSONDictionaryFull;
    NSDictionary *JSONDictionaryMini;
    BoxFile *file;
    BoxFile *miniFile;
}

@end
