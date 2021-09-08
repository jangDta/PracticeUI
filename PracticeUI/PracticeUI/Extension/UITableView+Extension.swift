//
//  UITableView+Extension.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/06.
//

import Foundation
import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}

extension UICollectionView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleItems.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}
