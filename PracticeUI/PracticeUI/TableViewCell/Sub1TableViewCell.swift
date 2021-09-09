//
//  Sub1TableViewCell.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/08/30.
//

import UIKit

class Sub1TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expandButton: UIButton!
        
    var model: [String] = [] {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UINib(nibName: AccountTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AccountTableViewCell.reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension Sub1TableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.reuseIdentifier, for: indexPath) as! AccountTableViewCell
        cell.title.text = model[indexPath.row]
        return cell
    }
    
    
}
