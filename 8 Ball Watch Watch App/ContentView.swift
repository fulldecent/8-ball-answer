//
//  ContentView.swift
//  8 Ball
//
//  Created by William Entriken on 2025-10-13.
//

import SwiftUI

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
    }
}

#Preview {
    ContentView()
}
