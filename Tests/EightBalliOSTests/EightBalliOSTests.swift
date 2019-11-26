//
//  ViewController.swift
//  8 Ball
//
//  Created by William Entriken on 11/4/15.
//  Copyright © 2015 William Entriken. All rights reserved.
//

import XCTest
import EightBalliOS

open class EightBalliOSTests: XCTestCase {
    func testSmoke() {
        let controller = EightBallController(answers: ["YES!"])
        XCTAssertNotNil(controller)
    }
}
