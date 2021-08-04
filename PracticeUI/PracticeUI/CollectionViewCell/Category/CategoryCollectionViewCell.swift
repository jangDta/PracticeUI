//
//  CategoryCollectionViewCell.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let categoryItems = ["예적금", "외화", "대출", "연금*ISA", "카드", "증권", "투자"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: CategoryItemCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryItemCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CategoryCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryItemCollectionViewCell
        
        cell.titleLabel.text = categoryItems[indexPath.row]
        
        if indexPath.row == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = categoryItems[indexPath.row]
        return CGSize(width: label.intrinsicContentSize.width + 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
}
