//
//  UserTests.swift
//  BeeHiveTests
//
//  Created by Gambrell, John on 1/17/18.
//  Copyright © 2018 JPG. All rights reserved.
//

import XCTest



class UserTests: XCTestCase {
    var user: User!
    let networkManager = NetworkManager()
    var userDict: [String: String]!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        user = User(userName: "Test\(Int(arc4random_uniform(1000)))", firstName: "Swifty", lastName: "Workerton", roleId: "3", departmentId: "1", supervisorId: "4")
        userDict = user.asDictionary()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(user.firstName == "Swifty")
    }
    
    func testAsDictionary() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(userDict["firstname"] == "Swifty")
    }
    
//    func testAddUser() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//
//        let exp = expectation(description: "Add user")
//        networkManager.addUser(user: user) { (result) in
//          XCTAssert(result.isSuccess)
//            exp.fulfill()
//        }
//
//        wait(for: [exp], timeout: 5)
//
//    }
    func testGetUser(){
        let exp = expectation(description: "Get user")
        networkManager.getUser(userId: "TestUser")
       //  exp.fulfill()
        wait(for: [exp], timeout: 5)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
