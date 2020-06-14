//
//  CategoryVC.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let data: [Categories] = [Categories(categoryImage: #imageLiteral(resourceName: "animal category"), categoryName: "Animals"),
                              Categories(categoryImage: #imageLiteral(resourceName: "sports category"), categoryName: "Sports"),
                              Categories(categoryImage: #imageLiteral(resourceName: "food category"), categoryName: "Foods"),
                              Categories(categoryImage: #imageLiteral(resourceName: "music category"), categoryName: "Musics")]
                              //Categories(categoryImage: UIImage(named: "animal category")!, categoryName: "Test")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
        GlobalVariables.mainMenuSoundPlayed = true
    }

}

extension CategoryVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCVCell {
            cell.configure(with: data[indexPath.row])
            return cell
        } else {
            return CategoryCVCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gamePlayVC") as! GamePlayVC
        if indexPath.item == 0 {
            GlobalVariables.selectedCategory = data[indexPath.row].categoryName
            performSegue(withIdentifier: "toGamePlayVC", sender: nil)
        } else {
            let alert = UIAlertController(title: "Coming Soon!", message: "Sorry, it's under construction", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.5) {
//            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCVCell {
//                cell.mask?.transform = .init(scaleX: 0.95, y: 0.95)
//                cell.contentView.backgroundColor = UIColor(red: 161, green: 227, blue: 251, alpha: 1)
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.5) {
//            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCVCell {
//                cell.mask?.transform = .identity
//                cell.contentView.backgroundColor = .clear
//            }
//        }
    }
    
}
