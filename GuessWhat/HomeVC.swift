//
//  ViewController.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - VARIABLES
    @IBOutlet weak var cloudImg1: UIImageView!
    @IBOutlet weak var cloudImg2: UIImageView!
    @IBOutlet weak var cloudImg3: UIImageView!
    @IBOutlet weak var cloudImg4: UIImageView!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var howButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Call func to move cloud
        cloudMove(imageView: cloudImg1, speed: 3)
        cloudMove(imageView: cloudImg2, speed: 3)
        cloudMove(imageView: cloudImg3, speed: 3)
        cloudMove(imageView: cloudImg4, speed: 3)
        
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "mainbackground")
//        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        
        //Add shadow to play button
        playButton.layer.masksToBounds = false
        playButton.layer.shadowColor = UIColor(white: 0x000000, alpha: 1.0).cgColor
        playButton.layer.shadowOpacity = 1.0
        playButton.layer.shadowRadius = 2
        playButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        
        //Add shadow to how to play button
        howButton.layer.masksToBounds = false
        howButton.layer.shadowColor = UIColor(white: 0x000000, alpha: 1.0).cgColor
        howButton.layer.shadowOpacity = 1.0
        howButton.layer.shadowRadius = 2
        howButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
    }
    
    
    // MARK: - FUNCTION
    
    func cloudMove(imageView: UIImageView,speed:CGFloat) {
        let speeds = speed
        let imageSpeed = speeds / view.frame.size.width
        let averageSpeed = (view.frame.size.width - imageView.frame.origin.x) * imageSpeed
        
        UIView.animate(withDuration: TimeInterval(averageSpeed), delay: 0.0, options: .curveLinear, animations: {
            imageView.frame.origin.x = self.view.frame.size.width
        }, completion: { (_) in
            imageView.frame.origin.x = -imageView.frame.size.width
            self.cloudMove(imageView: imageView, speed: speeds)
        })
    }

}

