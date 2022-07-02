//
//  RealmListController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 29.06.22.
//

import UIKit
import RealmSwift

class RealmListController: UIViewController {
    @IBOutlet weak var tableViewRequest: UITableView!
    var provaider: RealmProviderProtocol!
    var notificationToken: NotificationToken?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRequest.delegate = self
        tableViewRequest.dataSource = self
        tableViewRequest.register(UINib(nibName: "ListRequestTableCell", bundle: nil), forCellReuseIdentifier: ListRequestTableCell.key)
        provaider = RealmProvader()
        let list = provaider.getResult(nameObject: RealmQueryList.self)
        notificationToken = list.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableViewRequest else { return }
            switch changes {
            case .initial: break
            case .update:
                tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
