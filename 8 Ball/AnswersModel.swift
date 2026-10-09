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
    let bundle = Bundle.main
    let url = bundle.url(forResource: "answers-by-locale", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    let decoded = try! decoder.decode([String: [String]].self, from: data)
    self.init(answersByLocale: decoded)
  }

  init(answersByLocale: [String: [String]]) {
    self.answersByLocale = answersByLocale
  }

  public func getAnswer(locale: Locale = .autoupdatingCurrent) -> String {
    answers(for: locale).randomElement()!
  }

  /// Keys in `answers-by-locale.json` are language codes (`en`, `de`) or
  /// language-and-script codes (`zh-Hans`). A locale with no matching key
  /// uses `en`.
  func answers(for locale: Locale) -> [String] {
    let language = locale.language.languageCode?.identifier
    let script = locale.language.script?.identifier
    var keys: [String] = []
    if let language, let script {
      keys.append("\(language)-\(script)")
    }
    if let language {
      keys.append(language)
    }
    if let script {
      keys.append(script)
    }
    keys.append("en")
    for key in keys {
      if let match = answersByLocale[key], !match.isEmpty {
        return match
      }
    }
    fatalError("answers-by-locale.json has no en answers")
  }
}
