//
//  Sub3ViewController.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/08.
//

import UIKit

class Sub3ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var animatedIndexPaths = [IndexPath]()
    
    var sections: [Section] = []
    
    var viewModel: OnceViewModelProtocol
    
    init(viewModel: OnceViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: Sub3ViewController.reuseIdentifier, bundle: nil)
        print("Sub3 Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Sub3 Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
        viewModel.load()
    }
    
    private func bind() {
        viewModel.onceModel.bind { [weak self] model in
            guard let self = self else { return }
            self.sections = model
        }
        
        viewModel.reloadSection.bind { [weak self] section in
            guard let self = self else { return }
            self.tableView.reloadSections([section], with: .automatic)
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 164
        
        tableView.register(UINib(nibName: Sub1TableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: Sub1TableViewCell.reuseIdentifier)
    }
    
    @objc func click(_ sender: UIButton) {
        viewModel.toggle(at: sender.tag)
    }
}


extension Sub3ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Sub1TableViewCell.reuseIdentifier, for: indexPath) as! Sub1TableViewCell
        cell.title.text = sections[indexPath.section].name
        cell.expandButton.tag = indexPath.section
        cell.expandButton.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        if sections[indexPath.section].expandable {
            cell.model = sections[indexPath.section].items
        } else {
            cell.model = []
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expandable {
            return CGFloat(sections[indexPath.section].items.count) * 50 + 164
        } else {
            return 164
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 12))
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.needAnimation(at: indexPath) {
            cell.alpha = 0.05
            cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height / 10)
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0.2,
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
