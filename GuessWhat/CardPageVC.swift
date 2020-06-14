//
//  CardPageVC.swift
//  GuessWhat
//
//  Created by Alnodi Adnan on 12/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit
//import AVFoundation

class CardPageVC: UIViewController {

    @IBOutlet weak var cardFrontView: UIImageView!
    @IBOutlet weak var cardBackView: UIImageView!
    @IBOutlet weak var cardDoneBtn: UIButton!
    
    var cardImages : [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //setupCardTap()
        randomizeCard()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.transition(from: self.cardFrontView!,
                              to: self.cardBackView!,
                              duration: 2,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            //self.cardDoneBtn.isHidden = false
            UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseIn, animations: {
                self.cardDoneBtn.alpha = 1.0
            }, completion: nil)
        }
    }
    
//    func setupCardTap(){
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.flipCard))
//        cardBackView.addGestureRecognizer(tapGesture)
//        let tapGestureFront = UITapGestureRecognizer(target: self, action: #selector(self.flipCardFront))
//        cardFrontView.addGestureRecognizer(tapGestureFront)
//    }
//
//    @objc func flipCard(){
//        UIView.transition(from: cardBackView!,
//                          to: cardFrontView!,
//                          duration: 2,
//                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
//                          completion: nil)
//        print("tap masuk")
//    }
//
//    @objc func flipCardFront(){
//        UIView.transition(from: cardFrontView!,
//                          to: cardBackView!,
//                          duration: 1,
//                          options: [.transitionFlipFromRight, .showHideTransitionViews],
//                          completion: nil)
//        print("tap masuk")
//    }
    
    func randomizeCard(){
        for i in 2...8 {
            print("card\(i)")
            cardImages.append(UIImage(named: "card\(i)")!)
        }
        
        let cardIndex = Int.random(in: 0...6)
        
        cardBackView.image = cardImages[cardIndex]
    }
    
    @IBAction func doneButton_Action(_ sender: Any) {
        
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    
}
