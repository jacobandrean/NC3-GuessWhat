//
//  GamePlayVC.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class GamePlayVC: UIViewController {

    // MARK: - VARIABLES
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var spriteImages = [UIImage]()
    var shuffledImage = [String]()
    var pickedShuffledImage = [String]()
    var stage = -1
    var duration = Int()
    var gameTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.bringSubviewToFront(startButton)
        view.bringSubviewToFront(timeLabel)
        changeBackground()
        
        //add shadow to startButton
        startButton.layer.masksToBounds = false
        startButton.layer.shadowColor = UIColor(white: 0x000000, alpha: 1.0).cgColor
        startButton.layer.shadowOpacity = 1.0
        startButton.layer.shadowRadius = 2
        startButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        
        //Restart counter
        GlobalVariables.trueAnswer = 0
        GlobalVariables.answerIsTrue.removeAll()
        
        randomImage()
    }
    
    
    // MARK: - FUNCTION
    
    func changeBackground() {
        switch GlobalVariables.selectedCategory {
        case "Animals":
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "animalbackground1")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
        default:
            break
        }
    }
    
    func randomImage() {
        pickedShuffledImage.removeAll()
        switch GlobalVariables.selectedCategory {
        case "Animals":
            shuffledImage = ["Monkey", "Butterfly", "Dog"].shuffled()
            print(shuffledImage)
            for i in 0..<shuffledImage.count {
                pickedShuffledImage.append(shuffledImage[i])
            }
            print(pickedShuffledImage)
        default:
            break
        }
    }
    
    func animatesSprite(){
        if stage < pickedShuffledImage.count {
            switch pickedShuffledImage[stage] {
            case "Butterfly":
                for i in 1...12 {
                    spriteImages.append(UIImage(named: "Butterfly\(i)")!)
                }
            case "Monkey":
                for i in 1...11 {
                    spriteImages.append(UIImage(named: "Monkey\(i)")!)
                }
            case "Dog":
                for i in 1...11 {
                    spriteImages.append(UIImage(named: "Dog\(i)")!)
                }
            default:
                break
            }
            imageView.animationImages = spriteImages
            imageView.animationDuration = 0.5
            imageView.animationRepeatCount = 0
            imageView.startAnimating()
            spriteImages.removeAll()
        }
    }
    
    func validateAnswer() {
        if startButton.titleLabel?.text == "True" {
            GlobalVariables.trueAnswer += 1
            GlobalVariables.answerIsTrue.append(true)
            print("Answer is true = \(GlobalVariables.answerIsTrue)")
            print("True answer = \(GlobalVariables.trueAnswer)")
        }
    }
    
    func timeOutAction2() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            print("\(self.duration) seconds left")
            self.timeLabel.text = "TIME \n \(self.duration)"
            self.duration -= 1
            
            if self.timeLabel.text == "TIME \n 0" {
                GlobalVariables.answerIsTrue.append(false)
                print(self.stage)
                self.stage += 1
                self.animatesSprite()
                self.duration = 5
                
                if self.stage == self.pickedShuffledImage.count {
                    timer.invalidate()
                    print("Answer is true = \(GlobalVariables.answerIsTrue)")
                    print("True answer = \(GlobalVariables.trueAnswer)")
                    self.performSegue(withIdentifier: "toScoreBoardVC", sender: nil)
                }
            }
        }
    }
    
    @objc func timeOutAction()  {
        print("\(self.duration) seconds left")
        self.timeLabel.text = "TIME \n \(self.duration)"
        self.duration -= 1
        
        if self.timeLabel.text == "TIME \n 0" {
            GlobalVariables.answerIsTrue.append(false)
            print(self.stage)
            self.stage += 1
            self.animatesSprite()
            self.duration = 5
            
            if self.stage == self.pickedShuffledImage.count {
                gameTimer.invalidate()
                print("Answer is true = \(GlobalVariables.answerIsTrue)")
                print("True answer = \(GlobalVariables.trueAnswer)")
                self.performSegue(withIdentifier: "toScoreBoardVC", sender: nil)
            }
        }
    }
    
    
    // MARK: - BUTTON TAPPED
    
    @IBAction func startTapped(_ sender: Any) {
        //timeOutAction2()
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeOutAction), userInfo: nil, repeats: true)
        timeLabel.isHidden = false
        duration = 4
        timeLabel.text = "TIME \n \(duration+1)"
        startButton.setTitle("True", for: .normal)
        stage += 1
        print("Stage: \(stage+1)")
        animatesSprite()
        validateAnswer()
        if stage == pickedShuffledImage.count {
            gameTimer.invalidate()
            performSegue(withIdentifier: "toScoreBoardVC", sender: nil)
        }
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        gameTimer.invalidate()
        dismiss(animated: true, completion: nil)
    }

}
