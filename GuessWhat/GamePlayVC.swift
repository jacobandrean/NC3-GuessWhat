//
//  GamePlayVC.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class GamePlayVC: UIViewController {

    @IBOutlet weak var labeltest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labeltest.text = GlobalVariables.selectedName
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
