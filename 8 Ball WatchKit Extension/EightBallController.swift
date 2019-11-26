//
//  EightBallController.swift
//  8 Ball WatchKit Extension
//
//  Created by Yaroslav Zhurakovskiy on 26.11.2019.
//  Copyright © 2019 William Entriken. All rights reserved.
//

import WatchKit

open class EightBallController: WKInterfaceController {
    @IBOutlet var theButton: WKInterfaceButton!
    
    private var answers: [String] = []
    
    @IBAction func buttonPressed() {
        guard let random = answers.randomElement() else {
            return
        }
        
        self.theButton.setTitle(random)
    }
    
    override open func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let input = context as? [String] {
            answers = input
        }
    }
    
    override open func willActivate() {
        self.theButton.setTitle("Tap for answer")
        super.willActivate()
    }
}
