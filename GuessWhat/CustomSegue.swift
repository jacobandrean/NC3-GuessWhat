//
//  CustomSegue.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 14/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        let fromView = source as UIViewController
        let toView = destination as UIViewController
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
        
        destination.view.alpha = 0.0
        window.insertSubview(destination.view, belowSubview: source.view)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            fromView.view.alpha = 0.0
            toView.view.alpha = 1.0
        }) { (finished) -> Void in
            fromView.view.alpha = 1.0
            fromView.present(self.destination, animated: false, completion: nil)
        }
    }
}
