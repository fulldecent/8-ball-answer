//
//  ViewController.swift
//  8 Ball
//
//  Created by William Entriken on 11/4/15.
//  Copyright © 2015 William Entriken. All rights reserved.
//

import UIKit

open class EightBallController: UIViewController {
    @IBOutlet weak var answer: UILabel!
    
    private var rolling = false
    
    private var answers: [String] 
    
    public init(answers: [String]) {
        self.answers = answers
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        self.answers = []
        super.init(coder: coder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        answer = createLabel()
        
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
    
    private func createLabel() -> UILabel {
        let answer = UILabel()
        answer.translatesAutoresizingMaskIntoConstraints = false
        answer.font = .systemFont(ofSize: 80, weight: .bold)
        answer.textColor = .white
        answer.textAlignment = .center
        answer.lineBreakMode = .byWordWrapping
        answer.numberOfLines = 0
        view.addSubview(answer)

        if #available(iOS 11.0, *) {
            ({
                let leadingAnchor = view.layoutMarginsGuide.leadingAnchor
                let constraint = answer.leadingAnchor.constraint(equalTo: leadingAnchor)
                constraint.constant = 0
                constraint.isActive = true
            })()
            ({
                let trailingAnchor = view.layoutMarginsGuide.trailingAnchor
                let constraint = answer.trailingAnchor.constraint(equalTo: trailingAnchor)
                constraint.constant = 0
                constraint.isActive = true
            })()
            ({
                let topAnchor = view.safeAreaLayoutGuide.topAnchor
                let constraint = answer.topAnchor.constraint(equalTo: topAnchor)
                constraint.constant = 10
                constraint.isActive = true
            })()
            ({
                let bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
                let constraint = answer.bottomAnchor.constraint(equalTo: bottomAnchor)
                constraint.constant = -10
                constraint.isActive = true
            })()
        } else {
            ({
                let leadingAnchor = view.layoutMarginsGuide.leadingAnchor
                let constraint = answer.leadingAnchor.constraint(equalTo: leadingAnchor)
                constraint.constant = 0
                constraint.isActive = true
            })()
            ({
                let trailingAnchor = view.layoutMarginsGuide.trailingAnchor
                let constraint = answer.trailingAnchor.constraint(equalTo: trailingAnchor)
                constraint.constant = 0
                constraint.isActive = true
            })()
            ({
                let topAnchor = view.layoutMarginsGuide.topAnchor
                let constraint = answer.topAnchor.constraint(equalTo: topAnchor)
                constraint.constant = 10
                constraint.isActive = true
            })()
            ({
                let bottomAnchor = view.layoutMarginsGuide.bottomAnchor
                let constraint = answer.bottomAnchor.constraint(equalTo: bottomAnchor)
                constraint.constant = -10
                constraint.isActive = true
            })()
        }
        
        return answer
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reset()
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
}
