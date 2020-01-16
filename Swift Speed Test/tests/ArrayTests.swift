//
//  ArrayTests.swift
//  Swift Speed Test
//
//  Created by Piotr Sochalewski on 02.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import XCTest

class ArrayTests: XCTestCase {
    
    let repeatCount = 1_000_000
    var array = [String]()
    
    func arrayWithElements() -> [String] {
        var array = [String]()
        for _ in 0..<repeatCount {
            array.append("\(arc4random_uniform(1000))")
        }
        
        return array
    }
    
    override func setUp() {
        super.setUp()
        array = arrayWithElements()
    }
    
    func testAdd() {
        measure { 
            _ = self.arrayWithElements()
        }
    }
    
    // It contains time for refilling the array, so should subtract avg time testAdd from the result.
    func testAccess() {
        var string = String()
        
        measure { 
            for i in 0..<self.repeatCount {
                string = self.array[i]
            }
        }
        
        print(string)
    }
    
    func testRemove() {
        measure {
            for _ in 0..<self.repeatCount {
                self.array.removeLast()
            }
            self.array = self.arrayWithElements()
        }
    }
    
    func testFastEnum() {
        var string = String()
        
        measure { 
            for arrayObject in self.array {
                string = arrayObject
            }
        }
        
        print(string)
    }
    
}
