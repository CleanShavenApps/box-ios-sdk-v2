//
//  BoxUserTests.h
//  BoxSDK
//
//  Created on 8/14/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <XCTest/XCTest.h>

@class BoxComment;

@interface BoxCommentTests : XCTestCase
{
    NSDictionary *JSONDictionaryFull;
    NSDictionary *JSONDictionaryMini;
    BoxComment *comment;
    BoxComment *miniComment;
}
@end
