//
//  UserTests.swift
//  BeeHiveTests
//
//  Created by Gambrell, John on 1/17/18.
//  Copyright © 2018 JPG. All rights reserved.
//

import XCTest

class UserTests: XCTestCase {
    var user: User?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        user = User(userName: "John123", firstName: "Swifty", lastName: "Workerton", roleId: "3", departmentId: "1", supervisorId: "4")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(user?.firstName == "Swifty")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
