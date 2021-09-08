//
//  CategoryItemCollectionViewCell.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            cardView.backgroundColor = .purple
            titleLabel.textColor = .white
        } else {
            cardView.backgroundColor = .white
            titleLabel.textColor = .lightGray
        }
      }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 6
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1).cgColor
        cardView.layer.masksToBounds = true
    }
}
