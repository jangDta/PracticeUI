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
    
    var sections: [Section] = [
        Section(name: "Section1", items: ["Item1", "Item2", "Item3"], expandable: false),
        Section(name: "Section2", items: ["Item1", "Item2"], expandable: false),
        Section(name: "Section3", items: ["Item1", "Item2", "Item3"], expandable: false),
        Section(name: "Section4", items: ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9"], expandable: false)
    ]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Sub1TableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: Sub1TableViewCell.reuseIdentifier)
    }
    
    @objc func click(_ sender: UIButton) {
        let section = sender.tag
        sections[section].expandable.toggle()
        tableView.reloadSections([section], with: .none)
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
            return CGFloat(sections[indexPath.section].items.count) * 40 + 120
        } else {
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !animatedIndexPaths.contains(indexPath) {
            animatedIndexPaths.append(indexPath)
            
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height / 4)
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0.2 * Double(indexPath.section),
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
