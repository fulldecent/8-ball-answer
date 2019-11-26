//
//  ViewController.swift
//  8 Ball
//
//  Created by William Entriken on 11/4/15.
//  Copyright © 2015 William Entriken. All rights reserved.
//

import UIKit

class EightBallController: UIViewController {
    @IBOutlet weak var answer: UILabel!
    
    private var rolling = false
    
    private var answers: [String] 
    
    init(answers: [String]) {
        self.answers = answers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.answers = []
        super.init(coder: coder)
    }
    
    @objc public func reset() {
        self.answer.text = "Tap for answer"
    }
    
    @objc public func reroll() {
        if (self.rolling) {
            return
        }
        
        guard let random = answers.randomElement() else {
            return
        }
        
        self.rolling = true
        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.answer.alpha = 0
            },
            completion: { finished in
                self.answer.text = random
                self.answer.alpha = 1
                self.rolling = false
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reset),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(reroll))
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reset()
    }
}
