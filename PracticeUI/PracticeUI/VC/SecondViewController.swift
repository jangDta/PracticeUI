//
//  SecondViewController.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/08/05.
//

import UIKit
import Floaty
import JJFloatingActionButton

class SecondViewController: UIViewController {

    @IBOutlet weak var floaty: Floaty!
    
    let animationTypes: [FloatyOpenAnimationType] = [.none, .fade, .pop, .slideDown, .slideLeft, .slideUp]
    
    let image1 = UIImage(systemName: "sun.min")?.applyingSymbolConfiguration(.init(scale: .large))
    let image2 = UIImage(systemName: "sun.min.fill")?.applyingSymbolConfiguration(.init(scale: .large))
    
    @IBOutlet weak var floating: UIButton!
    @IBOutlet weak var floating1: UIButton!
    @IBOutlet weak var floating2: UIButton!
    @IBOutlet weak var floating3: UIButton!
    
    var buttons: [UIButton] = []
    
    var isShowFloating: Bool = false {
        didSet {
            if isShowFloating {
                buttons.forEach { [weak self] button in
                    button.isHidden = false
                    button.alpha = 0

                    UIView.animate(withDuration: 0.3) {
                        button.alpha = 1
                        self?.view.layoutIfNeeded()
                    }
                }
            } else {
                buttons.reversed().forEach { button in
                    UIView.animate(withDuration: 0.3) {
                        button.isHidden = true
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFloaty()
        
        buttons = [floating1, floating2, floating3]
    }
    
    private func configureFloaty() {
        floaty.addItem("아이템1", icon: image1, handler: { item in
            print(item.title)
        })
        floaty.addItem("아이템2", icon: image2, handler: { item in
            self.floaty.close()
        })
    }
    @IBAction func floatingAction(_ sender: UIButton) {
        isShowFloating.toggle()
    }
}
