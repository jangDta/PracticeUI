//
//  TabBarViewController.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/08/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarUI()
    }
    
    private func configureTabBarUI() {
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage() // add this if you want remove tabBar separator
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear
        tabBar.layer.backgroundColor = UIColor.clear.cgColor
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight) // here you can change blur style
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: tabBar.frame.height + view.safeAreaLayoutGuide.layoutFrame.height)
        blurView.autoresizingMask = .flexibleWidth
        tabBar.insertSubview(blurView, at: 0)
    }
    

}
