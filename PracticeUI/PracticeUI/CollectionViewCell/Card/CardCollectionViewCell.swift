//
//  CardCollectionViewCell.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/06.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
    }

}
