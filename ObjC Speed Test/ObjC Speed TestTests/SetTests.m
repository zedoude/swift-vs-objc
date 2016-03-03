//
//  SetTests.m
//  ObjC Speed Test
//
//  Created by Piotr Sochalewski on 03.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

// Frameworks
@import XCTest;

@interface SetTests: XCTestCase

@property (strong, nonatomic) NSMutableSet *set;
@property (assign, nonatomic, readonly) NSInteger repeatCount;

@end

@implementation SetTests

- (NSInteger)repeatCount {
    return 1000000; // one million
}

- (NSMutableSet *)setWithElements {
    NSMutableSet *set = [NSMutableSet new];
    for (NSInteger i = 0; i < self.repeatCount; i++) {
        [set addObject:[NSString stringWithFormat:@"%li", (long)i]];
    }
    
    return set;
}

- (void)setUp {
    [super setUp];
    self.set = [self setWithElements];
}

- (void)testAdd {
    [self measureBlock:^{
        [self setWithElements];
    }];
}

- (void)testAccess {
    [self measureBlock:^{
        for (NSInteger i = 0; i < self.repeatCount; i++) {
            [self.set containsObject:[NSString stringWithFormat:@"%li", (long)i]];
        }
    }];
}

- (void)testRemove {
#warning It contains time for refilling the set, so should subtract avg time testAdd from the result.
    [self measureBlock:^{
        for (NSInteger i = 0; i < self.set.count; i--) {
            [self.set removeObject:[NSString stringWithFormat:@"%li", (long)i]];
        }
        self.set = [self setWithElements];
    }];
}

- (void)testFastEnum {
    __block NSString *string;
    
    [self measureBlock:^{
        for (NSString *setElemement in self.set) {
            string = setElemement;
        }
    }];
}

@end