//
//  SetTests.swift
//  Swift Speed Test
//
//  Created by Piotr Sochalewski on 03.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import XCTest

class SetTests: XCTestCase {
    
    let repeatCount = 1_000_000
    var set = Set<String>()
    
    func setWithElements() -> Set<String> {
        var set = Set<String>()
        for i in 0..<repeatCount {
            set.insert("\(i)")
        }
        
        return set
    }
    
    override func setUp() {
        super.setUp()
        set = setWithElements()
    }
    
    func testAdd() {
        measureBlock {
            _ = self.setWithElements()
        }
    }
    
    func testContains() {
        measureBlock { 
            for i in 0..<self.repeatCount {
                _ = self.set.contains("\(i)")
            }
        }
    }
    
    // It contains time for refilling the set, so should subtract avg time testAdd from the result.
    func testRemove() {
        measureBlock { 
            for i in 0..<self.repeatCount {
                self.set.remove("\(i)")
            }
            self.set = self.setWithElements()
        }
    }
    
    func testFastEnum() {
        measureBlock { 
            for setElement in self.set {
                _ = setElement
            }
        }
    }
    
}
