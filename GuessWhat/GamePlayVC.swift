//
//  GamePlayVC.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class GamePlayVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labeltest: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var objectImage = [UIImage]()
    var shuffledImage = [String]()
    var pickedImage = [String]()
    
    var stage = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        GlobalVariables.trueAnswer = 0
        timeLabel.text = "Time"
        labeltest.text = GlobalVariables.selectedCategory
        randomImage()
    }
    
    func randomImage() {
        pickedImage.removeAll()
        switch GlobalVariables.selectedCategory {
        case "Animals":
            shuffledImage = ["Monkey", "Butterfly", "Dog"].shuffled()
            print(shuffledImage)
            for i in 0...shuffledImage.count-2 {
                pickedImage.append(shuffledImage[i])
            }
            print(pickedImage)
        default:
            break
        }
    }
    
    func animatesSprite()
    {
        print(pickedImage.count)
        if stage < pickedImage.count{
            
            switch pickedImage[stage] {
            case "Butterfly":
                for i in 1...12
                {
                    objectImage.append(UIImage(named: "Butterfly\(i)")!)
                }
            case "Monkey":
                for i in 1...11
                {
                    objectImage.append(UIImage(named: "Monkey\(i)")!)
                }
            case "Dog":
                for i in 1...11
                {
                    objectImage.append(UIImage(named: "Dog\(i)")!)
                }
            default:
                break
            }
            
            imageView.animationImages = objectImage
            imageView.animationDuration = 0.5
            imageView.animationRepeatCount = 0
            imageView.startAnimating()
        }
    
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        startButton.setTitle("True", for: .normal)
            stage += 1
            labeltest.text = "\(stage)"
            animatesSprite()
        
            objectImage.removeAll()
            
            if startButton.titleLabel?.text == "True" {
                GlobalVariables.trueAnswer += 1
                print(GlobalVariables.trueAnswer)
            }
            
            if stage == pickedImage.count {
                performSegue(withIdentifier: "toScoreBoardVC", sender: nil)
            }
            
            if stage < pickedImage.count {
                GlobalVariables.answerList.append(true)
                print(GlobalVariables.answerList)
            }
    }
    
}
