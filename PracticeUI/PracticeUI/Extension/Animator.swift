//
//  Animator.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/06.
//

import Foundation
import UIKit

typealias Animation = (UICollectionViewCell, IndexPath, UICollectionView) -> Void

final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UICollectionViewCell, at indexPath: IndexPath, in tableView: UICollectionView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, tableView)

        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}

enum AnimationFactory {

    static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, _ in
            cell.alpha = 0

            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }
    
    static func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight / 4)

            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.2,
                options: [.curveEaseInOut],
                animations: {
                    cell.alpha = 1
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}
