//
//  TestsListViewController.swift
//  TV App
//
//  Created by Bindu on 17/03/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import XCTest
@testable import TV_App

class TestsListViewController: XCTestCase {

    var vc: ListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ListViewController()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsViewNil() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(vc.view)
    }

    
    
}
