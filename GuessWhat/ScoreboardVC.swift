//
//  ScoreboardVC.swift
//  GuessWhat
//
//  Created by Alnodi Adnan on 12/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class ScoreboardVC: UIViewController {
    
    
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @IBOutlet weak var winLoseLogo: UIImageView!
    @IBOutlet weak var winLoseTitleLabel: UILabel!
    @IBOutlet weak var winLoseDetailLabel: UILabel!
    @IBOutlet weak var scoreboardView: UITableView!
    
    var scoreboardResult = [wordAnswered]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        insertDummyData()
        
        scoreboardView.delegate = self
        scoreboardView.dataSource = self
        scoreboardView.register(UINib(nibName: "ScoreboardViewCell", bundle: nil), forCellReuseIdentifier: "scoreboardCellID")
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            scoreboardView.isHidden = true
            performSegue(withIdentifier: "toPopUpSegue", sender: self)
            blurEffectView.isHidden = false
        }
    }
    
}

extension ScoreboardVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreboardResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCellID", for: indexPath) as! ScoreboardViewCell
        
        cell.configure(with: scoreboardResult[indexPath.row])
        
        return cell
    }
    
    
    func insertDummyData(){
        scoreboardResult.append(wordAnswered(word: "Monkey", correct: true))
        scoreboardResult.append(wordAnswered(word: "Dog", correct: true))
        scoreboardResult.append(wordAnswered(word: "Butterfly", correct: false))
    }
    
}
