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
                              Categories(categoryImage: #imageLiteral(resourceName: "music category"), categoryName: "Musics"),
                              Categories(categoryImage: UIImage(named: "animal category")!, categoryName: "Test")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        print(data[indexPath.row].categoryImage)
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gamePlayVC") as! GamePlayVC
//        vc.labeltest.text = data[indexPath.row].categoryName
        GlobalVariables.selectedCategory = data[indexPath.row].categoryName
        performSegue(withIdentifier: "toGamePlayVC", sender: nil)
    }
    
}
