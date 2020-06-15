//
//  ScoreboardVC.swift
//  GuessWhat
//
//  Created by Alnodi Adnan on 12/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit
import AVFoundation

class ScoreboardVC: UIViewController {
    
    
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @IBOutlet weak var winLoseLogo: UIImageView!
    @IBOutlet weak var winLoseTitleLabel: UILabel!
    @IBOutlet weak var winLoseDetailLabel: UILabel!
    @IBOutlet weak var scoreboardView: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var shakeLabel: UILabel!
    
    
    var scoreboardResult = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupResultLogo()
        
        scoreboardView.delegate = self
        scoreboardView.dataSource = self
        scoreboardView.register(UINib(nibName: "ScoreboardViewCell", bundle: nil), forCellReuseIdentifier: "scoreboardCellID")
        
        //Add shadow to homeButton
        homeButton.layer.masksToBounds = false
        homeButton.layer.shadowColor = UIColor(white: 0x000000, alpha: 1.0).cgColor
        homeButton.layer.shadowOpacity = 1.0
        homeButton.layer.shadowRadius = 2
        homeButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GlobalVariables.mainMenuAudioPlayer.setVolume(0, fadeDuration: 2)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake  && !(GlobalVariables.trueAnswer > (scoreboardResult.count / 2)){
            scoreboardView.isHidden = true
            performSegue(withIdentifier: "toPopUpSegue", sender: self)
            blurEffectView.isHidden = false
        }
    }
    
    func setupResultLogo(){
        //Kalau menang
        if GlobalVariables.trueAnswer > (scoreboardResult.count / 2) {
            winLoseLogo.image = UIImage(named: "win assets")
            winLoseTitleLabel.text = "You win!"
            winLoseDetailLabel.text = "You got \(GlobalVariables.trueAnswer) answers right"
            
            homeButton.isHidden = false
            shakeLabel.isHidden = true
        }
            //Kalau kalah
        else{
            winLoseLogo.image = UIImage(named: "lose assets")
            winLoseTitleLabel.text = "You lose!"
            winLoseDetailLabel.text = "We challenge you to answer a card"
            
            homeButton.isHidden = true
            shakeLabel.isHidden = false
        }
    }
    
    @IBAction func homeButton_Action(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
}

extension ScoreboardVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreboardResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCellID", for: indexPath) as! ScoreboardViewCell
        
        cell.wordAnsweredLabel.text = scoreboardResult[indexPath.row]
        
        if GlobalVariables.answerIsTrue[indexPath.row] {
            cell.wordAnsweredLabel.textColor = .white
        }
        else{
            cell.wordAnsweredLabel.textColor = .darkGray
        }
        
        return cell
    }
    
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
