//
//  ContentView.swift
//  8 Ball
//
//  Created by William Entriken on 2025-10-13.
//

import SwiftUI
#if os(macOS)
import AppKit
#endif

private func localeFromLaunchArguments() -> Locale {
  let arguments = ProcessInfo.processInfo.arguments
  guard let index = arguments.firstIndex(of: "-AppleLocale"),
    arguments.indices.contains(index + 1)
  else {
    return .autoupdatingCurrent
  }
  return Locale(identifier: arguments[index + 1])
}

#if os(macOS)
enum MacScreenshot {
  static let width: CGFloat = 1440
  static let height: CGFloat = 900

  /// Writes a 1440×900 PNG and exits when launched with `-screenshot-file`.
  /// The App Store runner cannot see another app's window without Screen Recording permission.
  static func exportIfRequested(answers: AnswersModel) {
    let arguments = ProcessInfo.processInfo.arguments
    guard let index = arguments.firstIndex(of: "-screenshot-file"),
      arguments.indices.contains(index + 1)
    else { return }

    let fortune = arguments.contains("-screenshot")
      ? answers.getAnswer(locale: localeFromLaunchArguments())
      : "Tap for answer"
    let renderer = ImageRenderer(
      content: AnswerCanvas(fortune: fortune)
        .frame(width: width, height: height)
    )
    renderer.scale = 1

    guard let image = renderer.nsImage,
      let tiff = image.tiffRepresentation,
      let rep = NSBitmapImageRep(data: tiff),
      rep.pixelsWide == Int(width),
      rep.pixelsHigh == Int(height),
      let png = rep.representation(using: .png, properties: [:])
    else {
      fputs("could not render a \(Int(width))×\(Int(height)) Mac screenshot\n", stderr)
      exit(1)
    }

    let url = URL(fileURLWithPath: arguments[index + 1])
    do {
      try FileManager.default.createDirectory(
        at: url.deletingLastPathComponent(),
        withIntermediateDirectories: true
      )
      try png.write(to: url)
    } catch {
      fputs("could not write Mac screenshot: \(error)\n", stderr)
      exit(1)
    }
    exit(0)
  }
}

private struct AnswerCanvas: View {
  let fortune: String

  var body: some View {
    Text(fortune)
      .font(.system(size: 500))
      .fontWeight(.bold)
      .foregroundColor(.white)
      .multilineTextAlignment(.center)
      .minimumScaleFactor(0.01)
      .lineLimit(nil)
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.black)
  }
}
#endif

struct ContentView: View {
  @State private var fortune = "Tap for answer"
  @State private var scale: CGFloat = 1.0
  @State private var answersModel: AnswersModel = .init()

  var body: some View {
    Text(fortune)
      .font(.system(size: 500))  // Start with a very large size
      .fontWeight(.bold)
      .foregroundColor(.white)
      .multilineTextAlignment(.center)
      .minimumScaleFactor(0.01)  // Allow scaling down to 1% if needed
      .lineLimit(nil)
      .scaleEffect(scale, anchor: UnitPoint.center)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding()  // Add padding to prevent edge touching
      .background(Color.black)
      .edgesIgnoringSafeArea(.all)
      .onTapGesture {
        fortune = answersModel.getAnswer()
        self.scale = 1.8
        withAnimation(.easeIn(duration: 0.2)) {
          self.scale = 1.0
        }
      }
      .onAppear {
        if ProcessInfo.processInfo.arguments.contains("-screenshot") {
          fortune = answersModel.getAnswer(locale: localeFromLaunchArguments())
        }
      }
  }
}

#Preview {
  ContentView()
}
