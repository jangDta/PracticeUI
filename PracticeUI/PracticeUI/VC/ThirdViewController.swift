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
    
    var viewModel: FinanceViewModelProtocol = FinanceViewModel(scrapingService: ScrapingService())
    
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
        let viewModel = OnceViewModel(onceService: OnceService(storage: FinanceDataStorage()))
        let vc = Sub3ViewController(viewModel: viewModel)
        return vc
    }()
    
    private func bind() {
        // 자산 탭 인덱스
        viewModel.index.bind { [weak self] in
            guard let self = self else { return }
            switch $0 {
                case .한눈에:
                    self.sub3VC.view.isHidden = false
                    self.sub2VC.view.isHidden = true
                case .자산, .소비, .목표:
                    if !self.children.contains(self.sub2VC) {
                        self.add(asChildViewController: self.sub2VC)
                    }
                    self.sub3VC.view.isHidden = true
                    self.sub2VC.view.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        add(asChildViewController: sub3VC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tap(_ sender: UIButton) {
        guard let index = FinanceIndex.init(rawValue: sender.tag) else { return }
        viewModel.currentIndex = index
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
        viewModel.executeAllScraping()
    }
}
