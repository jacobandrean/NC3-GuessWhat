//
//  GamePlayVC.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit
import AVFoundation

class GamePlayVC: UIViewController {

    // MARK: - VARIABLES
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    var spriteImages = [UIImage]()
    var shuffledImage = [String]()
    var pickedShuffledImage = [String]()
    var stage = -1
    var duration = Int()
    var resetDuration = 19
    var gameTimer = Timer()
    var player: AVAudioPlayer?
    var timerPlayer: AVAudioPlayer?
    
    
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
        
        // Add shadow to exitButton
        exitButton.layer.masksToBounds = false
        exitButton.layer.shadowColor = UIColor(white: 0x000000, alpha: 1.0).cgColor
        exitButton.layer.shadowOpacity = 1.0
        exitButton.layer.shadowRadius = 2
        exitButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        
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
    
    func animatesSprite() {
        spriteImages.removeAll()
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
        }
    }
    
    @objc func timeOutAction()  {
        print("\(self.duration) seconds left")
        self.timeLabel.text = "TIME \n \(self.duration)"
        self.duration -= 1
        
        if self.duration == 4 {
            playTimerSound()
        }
        
        if self.timeLabel.text == "TIME \n 0" {
            playFailSound()
            GlobalVariables.answerIsTrue.append(false)
            print(self.stage)
            self.stage += 1
            self.animatesSprite()
            self.duration = resetDuration+1
            timerPlayer?.stop()
            
            if self.stage == self.pickedShuffledImage.count {
                gameTimer.invalidate()
                print("Answer is true = \(GlobalVariables.answerIsTrue)")
                print("True answer = \(GlobalVariables.trueAnswer)")
                self.performSegue(withIdentifier: "toScoreBoardVC", sender: nil)
            }
        }
    }
    
    
    // MARK: - ANIMATION FUNCTION
    var centerX: CGFloat = 0
    var centerY: CGFloat = 0
    
    /// x = -250 | 424  centerX = 87     left=0    right=174
    /// y for walking maks 500
    func setPosition(to: String) {
        if to == "left" {
            self.imageView.frame.origin.x = -350
            self.imageView.frame.origin.y = 500
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } else if to == "right" {
            self.imageView.frame.origin.x = 524
            self.imageView.frame.origin.y = 600
            self.imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        } else if to == "center" {
            self.imageView.frame.origin.x = 87
            self.imageView.frame.origin.y = 500
        }
    }
    
    func setPosition2(to: String, completion: (_ success: Bool) -> Void) {
        if to == "left" {
            self.imageView.frame.origin.x = 0//-350
            self.imageView.frame.origin.y = 500//500
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } else if to == "right" {
            self.imageView.frame.origin.x = 174//524
            self.imageView.frame.origin.y = 500//600
            self.imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        } else if to == "center" {
            self.imageView.frame.origin.x = 87
            self.imageView.frame.origin.y = 500
        }
        completion(true)
    }
    
    func randomAnimation() {
        imageView.stopAnimating()
        let randomInt = Int.random(in: 0...1)
        let randomInterval = Float.random(in: 1...3)
        switch randomInt {
        case 0:
            moveRightAnimation(timeInterval: TimeInterval(randomInterval))
        case 1:
            moveLeftAnimation(timeInterval: TimeInterval(randomInterval))
        default:
            moveRightAnimation(timeInterval: TimeInterval(randomInterval))
        }
    }
    
    func moveRightAnimation(timeInterval: TimeInterval) {
        setPosition(to: "left")
        
        UIView.animate(withDuration: timeInterval, animations: {
            self.imageView.frame.origin.x = -self.imageView.frame.origin.x + 200
        }) { (_) in
            if (self.imageView.frame.origin.x) > 87 {
                let randomInterval = Float.random(in: 1...3)
                self.moveLeftAnimation(timeInterval: TimeInterval(randomInterval))
            }
        }
    }

    func moveLeftAnimation(timeInterval: TimeInterval) {
        setPosition(to: "right")
        
        UIView.animate(withDuration: timeInterval, animations: {
            self.imageView.frame.origin.x = self.imageView.frame.origin.x - 824
        }) { (_) in
            if (self.imageView.frame.origin.x) < 87 {
                let randomInterval = Float.random(in: 1...3)
                self.moveRightAnimation(timeInterval: TimeInterval(randomInterval))
            }
        }
    }
    
    func moveCenterAnimation(timeInterval: TimeInterval) {
        centerX = self.view.bounds.width/2
        centerY = self.view.bounds.height/2
        self.imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        UIView.animate(withDuration: timeInterval, animations: {
            self.imageView.frame.origin.x = self.centerX
            self.imageView.frame.origin.y = self.centerY
        }) { (_) in
            //...
        }
    }
    
    // MARK: - BUTTON TAPPED
    
    fileprivate func setupTimer() {
        //timeOutAction2()
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeOutAction), userInfo: nil, repeats: true)
        timeLabel.isHidden = false
        duration = resetDuration
        timeLabel.text = "TIME \n \(duration+1)"
        startButton.setTitle("True", for: .normal)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        stage += 1
        print("Stage: \(stage+1)")
        
        
        
        if (startButton.titleLabel?.text == "Start"){
            GlobalVariables.mainMenuAudioPlayer.setVolume(0, fadeDuration: 1.5)
            GlobalVariables.mainMenuSoundPlayed = false
            startButton.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.startButton.isUserInteractionEnabled = true
                self.playGameplaySound()
                self.setupTimer()
                self.randomAnimation()
                self.animatesSprite()
            }
        } else if(startButton.titleLabel?.text == "True") {
            setupTimer()
            playTrueButtonSound()
            timerPlayer?.stop()
            randomAnimation()
            animatesSprite()
        }
    
        if startButton.titleLabel?.text == "True" {
            GlobalVariables.trueAnswer += 1
            GlobalVariables.answerIsTrue.append(true)
            print("Answer is true = \(GlobalVariables.answerIsTrue)")
            print("True answer = \(GlobalVariables.trueAnswer)")
        }
        
        if stage == pickedShuffledImage.count {
            gameTimer.invalidate()
            performSegue(withIdentifier: "toScoreBoardVC", sender: nil)
        }
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        if stage > -1 {
            let alert = UIAlertController(title: "Stop Game Alert!", message: "You can't pause the game! Do you want to stop the game?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                
                self.gameTimer.invalidate()
                
                let transition: CATransition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.fade
                transition.subtype = CATransitionSubtype.fromRight
                self.view.window!.layer.add(transition, forKey: nil)
                self.dismiss(animated: false, completion: nil)
                
                if(self.startButton.titleLabel?.text == "True"){
                    GlobalVariables.mainMenuAudioPlayer.setVolume(0, fadeDuration: 1)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.playMainMenuSound()
                    }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        
        } else {
            self.gameTimer.invalidate()
            
            let transition: CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false, completion: nil)
            
            if(self.startButton.titleLabel?.text == "True"){
                GlobalVariables.mainMenuAudioPlayer.setVolume(0, fadeDuration: 1)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.playMainMenuSound()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScoreBoardVC"{
            let destinationVC = segue.destination as! ScoreboardVC
            destinationVC.scoreboardResult = pickedShuffledImage
        }
    }
    
    func playTrueButtonSound() {
        guard let url = Bundle.main.url(forResource: "true", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playFailSound() {
        guard let url = Bundle.main.url(forResource: "fail_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playGameplaySound() {
        guard let url = Bundle.main.url(forResource: "animal_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            GlobalVariables.mainMenuAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            GlobalVariables.mainMenuAudioPlayer?.numberOfLoops = -1
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = GlobalVariables.mainMenuAudioPlayer else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playTimerSound() {
        guard let url = Bundle.main.url(forResource: "time_almost_done", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            timerPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = timerPlayer else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playMainMenuSound() {
        guard let url = Bundle.main.url(forResource: "main_menu_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            GlobalVariables.mainMenuAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            GlobalVariables.mainMenuAudioPlayer?.numberOfLoops = -1
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = GlobalVariables.mainMenuAudioPlayer else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
