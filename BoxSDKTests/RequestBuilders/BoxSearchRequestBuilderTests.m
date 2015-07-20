//
//  BoxSearchRequestBuilderTests.m
//  BoxSDK
//
//  Created on 11/21/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import "BoxSearchRequestBuilderTests.h"

#import "BoxSearchRequestBuilder.h"

@implementation BoxSearchRequestBuilderTests

- (void)testThatNilSearchQueryIsHandledCorrectlyOnInit
{
    BoxSearchRequestBuilder *builder = [[BoxSearchRequestBuilder alloc] initWithSearch:nil queryStringParameters:nil];
    XCTAssertEqualObjects(@{}, builder.queryStringParameters, @"query string should be empty");
}

- (void)testThatNilSearchQueryIsHandledCorrectlyOnSet
{
    BoxSearchRequestBuilder *builder = [[BoxSearchRequestBuilder alloc] init];
    builder.query = nil;
    XCTAssertEqualObjects(@{}, builder.queryStringParameters, @"query string should be empty");
}

- (void)testThatSearchQueryIsSetOnInit
{
    BoxSearchRequestBuilder *builder = [[BoxSearchRequestBuilder alloc] initWithSearch:@"foobar" queryStringParameters:nil];
    XCTAssertEqualObjects(@{@"query" : @"foobar"}, builder.queryStringParameters, @"query string should be set");
}

- (void)testThatSearchQueryIsSetOnSet
{
    BoxSearchRequestBuilder *builder = [[BoxSearchRequestBuilder alloc] init];
    builder.query = @"foobar";
    XCTAssertEqualObjects(@{@"query" : @"foobar"}, builder.queryStringParameters, @"query string should be set");
}

@end
