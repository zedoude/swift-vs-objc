//
//  DictionaryTests.m
//  ObjC Speed Test
//
//  Created by Piotr Sochalewski on 03.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

// Framework
@import XCTest;

@interface DictionaryTests: XCTestCase

@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (assign, nonatomic, readonly) NSInteger repeatCount;

@end

@implementation DictionaryTests

- (NSInteger)repeatCount {
    return 1000000; // one million
}

- (void)setUp {
    [super setUp];
    self.dictionary = [self dictionaryWithElements];
}

- (NSMutableDictionary *)dictionaryWithElements {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (NSInteger i = 0; i < self.repeatCount; i++) {
        dictionary[[NSString stringWithFormat:@"%li", (long)i]] = [NSString stringWithFormat:@"%i", arc4random_uniform(1000)];
    }
    
    return dictionary;
}

- (void)testAdd {
    [self measureBlock:^{
        [self dictionaryWithElements];
    }];
}

- (void)testAccess {
    __block NSMutableString *string;

    [self measureBlock:^{
        for (NSInteger i = 0; i < self.repeatCount; i++) {
            string = self.dictionary[[NSString stringWithFormat:@"%li", (long)i]];
        }
    }];
}

- (void)testRemove {
#warning It contains time for refilling the dictionary, so should subtract avg time testAdd from the result.
    [self measureBlock:^{
        for (NSInteger i = 0; i < self.repeatCount; i++) {
            [self.dictionary removeObjectForKey:[NSString stringWithFormat:@"%li", (long)i]];
        }
        self.dictionary = [self dictionaryWithElements];
    }];
}

@end
