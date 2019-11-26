//
//  __BallUITests.swift
//  8 BallUITests
//
//  Created by Full Decent on 5/11/16.
//  Copyright © 2016 William Entriken. All rights reserved.
//

import XCTest

class iOSExampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testExample() {
        let app = XCUIApplication()
        snapshot("0Launch")
        app.buttons.firstMatch.tap()
        app.staticTexts["Tap for answer"].tap()
        snapshot("1HasAnswer")
    }
    
}
