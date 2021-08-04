//
//  MainCollectionViewCell.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 10
    }

}
