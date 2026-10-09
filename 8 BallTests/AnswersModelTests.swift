import Foundation
import Testing

@testable import __Ball

@MainActor
struct AnswersModelTests {
  @Test func englishLocaleUsesTheEnglishAnswers() {
    let model = AnswersModel(answersByLocale: [
      "en": ["Yes", "No"],
      "de": ["Ja", "Nein"],
    ])
    #expect(model.answers(for: Locale(identifier: "en_US")) == ["Yes", "No"])
  }

  @Test func languageCodeSelectsThatLocalesAnswers() {
    let model = AnswersModel(answersByLocale: [
      "en": ["Yes"],
      "de": ["Ja", "Nein"],
    ])
    #expect(model.answers(for: Locale(identifier: "de_DE")) == ["Ja", "Nein"])
  }

  @Test func languageAndScriptSelectTheMatchingKey() {
    let model = AnswersModel(answersByLocale: [
      "en": ["Yes"],
      "zh-Hans": ["是"],
    ])
    #expect(model.answers(for: Locale(identifier: "zh-Hans")) == ["是"])
  }

  @Test func unknownLocaleFallsBackToEnglish() {
    let model = AnswersModel(answersByLocale: [
      "en": ["Yes"]
    ])
    #expect(model.answers(for: Locale(identifier: "ja_JP")) == ["Yes"])
  }

  @Test func bundledAnswersIncludeTheEnglishSet() {
    let answers = AnswersModel().answers(for: Locale(identifier: "en"))
    #expect(answers.contains("It is certain"))
    #expect(answers.contains("Very doubtful"))
  }

  @Test func getAnswerReturnsOneOfTheSelectedAnswers() {
    let model = AnswersModel(answersByLocale: [
      "en": ["Yes", "No"]
    ])
    let answer = model.getAnswer(locale: Locale(identifier: "en"))
    #expect(["Yes", "No"].contains(answer))
  }
}
