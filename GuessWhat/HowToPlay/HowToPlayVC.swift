//
//  HowToPlayVC.swift
//  GuessWhat
//
//  Created by Amanda Greta on 13/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class HowToPlayVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var doneButton: UIButton!
    
    var views: [view2] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        scrollView.delegate = self
        views = createSlides()
        setupSlideScrollView(slides: views)
              
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
           
        doneButton.layer.cornerRadius = 8
        
        //Shadow done button
        doneButton.layer.masksToBounds = false
        doneButton.layer.shadowColor = UIColor(white: 0x000000, alpha: 1.0).cgColor
        doneButton.layer.shadowOpacity = 1.0
        doneButton.layer.shadowRadius = 2
        doneButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        
        // Do any additional setup after loading the view.
    }
    

        func createSlides() -> [view2] {
                        let slide1:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide1.imgV.image = UIImage(named: "cloud")
                        slide1.labelV.text = "You need at least 2 person"
                        slide1.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)
            
                        let slide2:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide2.imgV.image = UIImage(named: "cloud")
                        slide2.labelV.text = "Choose the player and don’t let one see the phone"
                        slide2.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)
            
                        let slide3:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide3.imgV.image = UIImage(named: "cloud")
                        slide3.labelV.text = "Choose the one who will hold the phone and give clue for the player"
                        slide3.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)
            
                        let slide4:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide4.imgV.image = UIImage(named: "cloud")
                        slide4.labelV.text = "The one that holds the phone will give the player a clue (sound / gestures)"
                        slide4.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)

                        let slide5:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide5.imgV.image = UIImage(named: "cloud")
                        slide5.labelV.text = "Click the true button once the player guess it right"
                        slide5.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)

                        let slide6:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide6.imgV.image = UIImage(named: "cloud")
                        slide6.labelV.text = "Guess the object"
                        slide6.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)

                        let slide7:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide7.imgV.image = UIImage(named: "cloud")
                        slide7.labelV.text = "Don’t forget that you have only 20 seconds to guess"
                        slide7.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)

                        let slide8:view2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as! view2
                        slide8.imgV.image = UIImage(named: "cloud")
                        slide8.labelV.text = "WARNING! If you lose, you need to answer a question from the card"
                        slide8.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.8901960784, blue: 0.9843137255, alpha: 1)

            return [slide1, slide2, slide3, slide4, slide5, slide6, slide7, slide8]
        }
        
        func setupSlideScrollView(slides : [view2]) {
            scrollView.frame = CGRect(x: 0, y: 219, width: 414, height: 265)
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: scrollView.frame.height)
            scrollView.isPagingEnabled = true
            
            for i in 0 ..< views.count {
                views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                scrollView.addSubview(views[i])
            }
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
    
    @IBAction func doneTapped(_ sender: Any) {
        let transition: CATransition = CATransition()
              transition.duration = 0.5
              transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
              transition.type = CATransitionType.fade
              transition.subtype = CATransitionSubtype.fromRight
              self.view.window!.layer.add(transition, forKey: nil)
              self.dismiss(animated: false, completion: nil)
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
