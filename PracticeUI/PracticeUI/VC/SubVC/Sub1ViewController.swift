//
//  Sub1ViewController.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/08/25.
//

import UIKit

protocol Sub1Delegate: class {
    func refresh()
}

class Sub1ViewController: UIViewController {
    
    var sections: [Section] = [
        Section(name: "Section1", items: ["Item1", "Item2", "Item3"], expandable: false),
        Section(name: "Section2", items: ["Item1", "Item2"], expandable: false),
        Section(name: "Section3", items: ["Item1", "Item2", "Item3"], expandable: false),
        Section(name: "Section4", items: ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9"], expandable: false)
    ]

    weak var delegate: Sub1Delegate?
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Sub1 Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Sub1 Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Sub1TableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: Sub1TableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: Sub1ContentTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: Sub1ContentTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: Sub1HeaderCell.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: Sub1HeaderCell.reuseIdentifier)
        tableView.register(UINib(nibName: Sub1FooterCell.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: Sub1FooterCell.reuseIdentifier)
        
    }
    
    @objc func click(_ sender: UIButton) {
        let section = sender.tag
        sections[section].expandable.toggle()
        tableView.reloadSections([section], with: .none)
    }
}

extension Sub1ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return !sections[section].expandable ? sections[section].items.count : 0
        return sections[section].expandable ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = .purple
        let button = UIButton(frame: CGRect(x: view.frame.maxX - 110, y: view.center.y - 10, width: 100, height: 20))
        button.setTitleColor(.white, for: .normal)
        button.setTitle("전체 보기", for: .normal)
        button.tag = section
        button.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        view.addSubview(button)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: Sub1HeaderCell.reuseIdentifier) as! Sub1HeaderCell
        cell.title.text = sections[section].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Sub1TableViewCell.reuseIdentifier, for: indexPath) as! Sub1TableViewCell
//        cell.title.text = sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Sub1ContentTableViewCell.reuseIdentifier, for: indexPath) as! Sub1ContentTableViewCell
        cell.model = sections[indexPath.section].items
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let itemCount = sections[indexPath.section].items.count
        return (CGFloat(itemCount / 2) + CGFloat(itemCount % 2)) * 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
