//
//  __BallTests.swift
//  8 BallTests
//
//  Created by William Entriken on 2025-10-13.
//

import Testing
import __Ball
internal import Foundation

struct __BallTests {

    @Test func example() async throws {
        let answersModel = await AnswersModel()
        let answer = await answersModel.getAnswer()
        
        #expect(answer.lengthOfBytes(using: .utf8) > 0)
    }

}
