//
//  ArrayTests.m
//  ObjC Speed Test
//
//  Created by Piotr Sochalewski on 02.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

// Frameworks
@import XCTest;

@interface ArrayTests: XCTestCase

@property (strong, nonatomic) NSMutableArray *array;
@property (assign, nonatomic, readonly) NSInteger repeatCount;

@end

@implementation ArrayTests

- (NSInteger)repeatCount {
    return 1000000; // one million
}

- (void)setUp {
    [super setUp];
    self.array = [self arrayWithElements];
}

- (NSMutableArray *)arrayWithElements {
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < self.repeatCount; i++) {
        [array addObject:[NSString stringWithFormat:@"%i", arc4random_uniform(1000)]];
    }
    
    return array;
}

- (void)testAdd {
    [self measureBlock:^{
        [self arrayWithElements];
    }];
}

- (void)testAccess {
    __block NSMutableString *string;
    
    [self measureBlock:^{
        for (NSInteger i = 0; i < self.repeatCount; i++) {
            string = self.array[i];
        }
    }];
}

- (void)testRemove {
#warning It contains time for refilling the array, so should subtract avg time testAdd from the result.
    [self measureBlock:^{
        for (NSInteger i = self.array.count; i >= 0; i--) {
            [self.array removeLastObject];
        }
        self.array = [self arrayWithElements];
    }];
}

- (void)testFastEnum {
    __block NSString *string;

    [self measureBlock:^{
        for (NSString *arrayElement in self.array) {
            string = arrayElement;
        }
    }];
}

@end
