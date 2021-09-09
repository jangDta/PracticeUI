//
//  Sub2ViewController.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/08/25.
//

import UIKit

class Sub2ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var animatedIndexPaths = [IndexPath]()
    
    var sections: [Section] = [
        Section(name: "Section1", items: ["Item1", "Item2", "Item3"], expandable: false),
        Section(name: "Section2", items: ["Item1", "Item2"], expandable: false),
        Section(name: "Section3", items: ["Item1", "Item2", "Item3", "Item1", "Item2", "Item3"], expandable: false),
        Section(name: "Section4", items: ["내통장리포트", "내카드리포트", "내 맘대로 목표추가", "Item4", "목표 추천받기", "쏠리치", "테마별 목표 추가", "소액투자", "건강자산관리"], expandable: false)
    ]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Sub2 Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Sub2 Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: CardCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: CategoryCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: CollectionHeaderView.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.reuseIdentifier)
    }

}

extension Sub2ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == sections.count - 1 { return 1 }
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == sections.count - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
            cell.categoryItems = sections[indexPath.section].items
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        cell.title.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.reuseIdentifier, for: indexPath) as! CollectionHeaderView
                headerView.title.text = sections[indexPath.section].name
                
                return headerView
            default:
                return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 40 - 10) / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if section == sections.count - 1 { return UIEdgeInsets.zero }
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("willDisplay \(indexPath)")
        
        if !animatedIndexPaths.contains(indexPath) {
            animatedIndexPaths.append(indexPath)
            let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.1)
            let animator = Animator(animation: animation)
            DispatchQueue.main.async {
                animator.animate(cell: cell, at: indexPath, in: collectionView)
            }
        }
        
    }
}
