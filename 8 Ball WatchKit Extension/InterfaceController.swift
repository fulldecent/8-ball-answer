//
//  InterfaceController.swift
//  8 Ball WatchKit Extension
//
//  Created by William Entriken on 11/4/15.
//  Copyright © 2015 William Entriken. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var theButton: WKInterfaceButton!
    
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
    
    @IBAction func buttonPressed() {
        let random = Int(arc4random_uniform(UInt32(self.answers.count)))
        self.theButton.setTitle(self.answers[random])
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        self.theButton.setTitle("Tap for answer")
        super.willActivate()
    }
}
