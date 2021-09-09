//
//  ThirdViewController.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/08/25.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var childControllers: [UIViewController] = []
    
    private lazy var sub1VC: Sub1ViewController = {
        let vc = Sub1ViewController(nibName: Sub1ViewController.reuseIdentifier, bundle: nil)
        vc.delegate = self
        return vc
    }()
    
    private lazy var sub2VC: Sub2ViewController = {
        let vc = Sub2ViewController(nibName: Sub2ViewController.reuseIdentifier, bundle: nil)
        return vc
    }()
    
    private lazy var sub3VC: Sub3ViewController = {
        let vc = Sub3ViewController(nibName: Sub3ViewController.reuseIdentifier, bundle: nil)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(asChildViewController: sub1VC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tap(_ sender: UIButton) {
        if sender.tag == 1 {
            sub1VC.view.isHidden = false
            sub2VC.view.isHidden = true
            sub3VC.view.isHidden = true
        } else if sender.tag == 2 {
            if !children.contains(sub3VC) {
                add(asChildViewController: sub3VC)
            }
            sub1VC.view.isHidden = true
            sub2VC.view.isHidden = true
            sub3VC.view.isHidden = false
        }else {
            if !children.contains(sub2VC) {
                add(asChildViewController: sub2VC)
            }
            sub1VC.view.isHidden = true
            sub2VC.view.isHidden = false
            sub3VC.view.isHidden = true
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        
        view.addSubview(viewController.view)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: viewController.view!, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view!, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view!, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view!, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParent()
    }
    
}

extension ThirdViewController: Sub1Delegate {
    func refresh() {
        print("refresh")
    }
}
