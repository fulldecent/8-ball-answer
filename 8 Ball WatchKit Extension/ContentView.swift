//
//  ContentView.swift
//  8 Ball WatchKit Extension
//
//  Created by William Entriken on 2020-01-01.
//  Copyright © 2020 William Entriken. All rights reserved.
//

import SwiftUI

var answers = [
    "It is certain",
    "It is decidedly so",
    "Without a doubt",
    "Yes definitely",
    "You may rely on it",
    "As I see it, yes",
    "Most likely",
    "Outlook good",
    "Yes",
    "Signs point to yes",
    "Reply hazy try again",
    "Ask again later",
    "Better not tell you now",
    "Cannot predict now",
    "Concentrate and ask again",
    "Don't count on it",
    "My reply is no",
    "My sources say no",
    "Outlook not so good",
    "Very doubtful"
]

struct ContentView: View {
    @State private var fortune = "Tap for an answer"
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Image("Twirl")
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth:.infinity, minHeight: 0, maxHeight: .infinity)
            
            Text(fortune)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .scaleEffect(scale, anchor: UnitPoint.center)
        }
        .onTapGesture {
            self.fortune = answers.randomElement()!
            self.scale = 1.8
            withAnimation(.easeIn(duration: 0.2)) {
                self.scale = 1.0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
