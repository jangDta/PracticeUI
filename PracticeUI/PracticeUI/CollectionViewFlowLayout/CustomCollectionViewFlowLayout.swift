//
//  CustomCollectionViewFlowLayout.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var stickyIndexPath: IndexPath? {
        didSet {
            // 레이아웃 새로 업데이트 해라
            invalidateLayout()
        }
    }
    
    init(stickyIndexPath: IndexPath?) {
        super.init()
        self.stickyIndexPath = stickyIndexPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func stickyAttributes(at indexPath: IndexPath?) -> UICollectionViewLayoutAttributes? {
        //stickyIndex에 해당하는 item의 layoutAttributes을 받음
        guard let collectionView = collectionView,
              let stickyIndexPath = indexPath,
              let stickyAttributes = layoutAttributesForItem(at: stickyIndexPath)?.copy() as? UICollectionViewLayoutAttributes
        else {
            return nil
        }
        
        // 받아온 layoutAttributes의 minY 값보다 더 scroll 된다면,
        // 1. 해당 attribute의 y값 조정을 통해 collectionView의 상위에 sticky 되어있는 것처럼 보이게하고,
        // 2. zIndex 조절을 통해 z축 상위로 올림.
        let collectionViewOffsetY = collectionView.contentOffset.y + 80 + UIApplication.shared.statusBarHeight
        if collectionViewOffsetY > stickyAttributes.frame.minY {
            var frame = stickyAttributes.frame
            frame.origin.y = collectionViewOffsetY
            stickyAttributes.frame = frame
            stickyAttributes.zIndex = 1
            return stickyAttributes
        }
        return nil
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 지정된 사각형 안에 있는 모든 셀 및 뷰의 레이아웃 특성을 반환
        // 레이아웃 프로세스의 마지막 단계에서 호출됨
        
        var layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        if let stickyAttributes = stickyAttributes(at: stickyIndexPath) {
            layoutAttributes?.append(stickyAttributes)
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // 스크롤 할 때 마다 Layout을 다시 계산할 것인가
        return true
    }
    
}
