//
//  ViewController.swift
//  8 Ball
//
//  Created by William Entriken on 11/4/15.
//  Copyright © 2015 William Entriken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var answer: UILabel!
    var rolling = false
    
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
    
    func reset() {
        self.answer.text = "Tap for answer"
    }
    
    @IBAction func reroll() {
        if (self.rolling) {
            return
        }
        self.rolling = true
        let random = Int(arc4random_uniform(UInt32(self.answers.count)))
        UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.answer.alpha = 0
            }, completion: { finished in
                self.answer.text = self.answers[random];
                self.answer.alpha = 1
                self.rolling = false
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reset", name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.reroll()
    }
    
}
