//
//  __BallApp.swift
//  8 Ball
//
//  Created by William Entriken on 2025-10-13.
//

import SwiftUI

@main
struct __BallApp: App {
  init() {
    #if os(macOS)
    MacScreenshot.exportIfRequested(answers: AnswersModel())
    #endif
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
