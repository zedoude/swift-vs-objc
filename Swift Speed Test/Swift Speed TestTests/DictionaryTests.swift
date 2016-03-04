//
//  DictionaryTests.swift
//  Swift Speed Test
//
//  Created by Piotr Sochalewski on 03.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import XCTest

class DictionaryTests: XCTestCase {
    
    let repeatCount = 1_000_000
    var dictionary = [String: String]()
    
    func dictionaryWithElements() -> [String: String] {
        var dictionary = [String: String]()
        for i in 0..<repeatCount {
            dictionary["\(i)"] = "\(arc4random_uniform(1000))"
        }
        
        return dictionary
    }
    
    override func setUp() {
        super.setUp()
        dictionary = dictionaryWithElements()
    }
    
    func testAdd() {
        measureBlock { 
            _ = self.dictionaryWithElements()
        }
    }
    
    func testAccess() {
        var string = String?()
        
        measureBlock { 
            for i in 0..<self.repeatCount {
                string = self.dictionary["\(i)"]
            }
        }
        
        print(string)
    }
    
    // It contains time for refilling the dictionary, so should subtract avg time testAdd from the result.
    func testRemove() {
        measureBlock {
            for i in 0..<self.repeatCount {
                self.dictionary.removeValueForKey("\(i)")
            }
            self.dictionary = self.dictionaryWithElements()
        }
    }
    
    func testFastEnum() {
        var string = String()
        
        measureBlock { 
            for (key, value) in self.dictionary {
                string = key + value
            }
        }
        
        print(string)
    }
    
}