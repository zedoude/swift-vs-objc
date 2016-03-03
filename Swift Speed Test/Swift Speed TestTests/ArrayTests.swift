//
//  ArrayTests.swift
//  Swift Speed Test
//
//  Created by Piotr Sochalewski on 02.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import XCTest

class ArrayTests: XCTestCase {
    
    let repeatCount = 2
    
    func arrayWithElements() -> [String] {
        var array = [String]()
        for _ in 0...repeatCount {
            array.append("\(arc4random_uniform(1000))")
        }
        
        return array
    }
    
    func testAdd() {
        measureBlock { 
            _ = self.arrayWithElements()
        }
    }
    
    func testAccess() {
        let array = arrayWithElements()
        
        var string = String()
        
        measureBlock { 
            for i in 0...self.repeatCount {
                string = array[i]
            }
        }
        
        print(string)
    }
    
    func testRemove() {
        
        measureBlock {
            var array = self.arrayWithElements()

            for i in 0...self.repeatCount {
                
                array.removeLast()
            }
        }
    }
    
    func testFastEnum() {
        let array = arrayWithElements()
        
        var string = String()
        
        measureBlock { 
            for arrayObject in array {
                string = arrayObject
            }
        }
        
        print(string)
    }
    
}
