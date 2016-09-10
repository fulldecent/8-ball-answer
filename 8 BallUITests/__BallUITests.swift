//
//  __BallUITests.swift
//  8 BallUITests
//
//  Created by Full Decent on 5/11/16.
//  Copyright © 2016 William Entriken. All rights reserved.
//

import XCTest

class __BallUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        snapshot("0Launch")
        app.staticTexts["Tap for answer"].tap()
        snapshot("1HasAnswer")
    }
    
}
