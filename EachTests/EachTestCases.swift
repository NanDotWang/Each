//
//  EachTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 9/8/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import Each

class EachTestCases: XCTestCase {
    
    var timer: Each!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        timer.stop()
    }
    
    func testEachSimple() {
        let exp = expectation(description: "Timer waiting")
        
        timer = Each(1).seconds
        timer.perform {
            exp.fulfill()
            return .stop
        }
        
        waitForExpectations(timeout: 1.1) { error in
            
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testEachStopInClosure() {
        let exp = expectation(description: "Timer waiting")
        
        timer = Each(1).seconds
        timer.perform() {
            exp.fulfill()
            return .stop
        }
        
        waitForExpectations(timeout: 1.1) { error in
            guard self.timer.isStopped else {
                XCTFail("The timer is not stopped even if the closure returns .stop")
                return
            }
            
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testEachStopAndStartAgain() {
        let exp = expectation(description: "Timer waiting")
        
        timer = Each(1).seconds
        timer.perform() {
            exp.fulfill()
            return .stop
        }
        
        timer.stop()
        timer.restart()
        
        waitForExpectations(timeout: 1.2) { error in
            guard let error = error else { return }
            print(error)
        }
    }
}
