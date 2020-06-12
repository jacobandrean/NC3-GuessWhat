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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            performSegue(withIdentifier: "toPopUpSegue", sender: self)
            blurEffectView.isHidden = false
        }
    }
    
}
