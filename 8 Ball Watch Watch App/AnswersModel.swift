//
//  AnswersModel.swift
//  8 Ball
//
//  Created by William Entriken on 2025-10-13.
//

import Foundation

public struct AnswersModel {
    private let answersByLocale: [String: [String]]
    
    public init() {
        // Load answers-by-locale.json
        let bundle = Bundle.main
        let url = bundle.url(forResource: "answers-by-locale", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        self.answersByLocale = try! decoder.decode([String: [String]].self, from: data)
    }
    
    public func getAnswer() -> String {
        let locale = Locale.autoupdatingCurrent
        let script = locale.language.script?.identifier ?? "en"
        let effectiveAnswers = answersByLocale[script] ?? answersByLocale["en"]!
        return effectiveAnswers.randomElement()!
    }
}
