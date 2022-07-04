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
            case .update(_, let deletions, let insertions, let modifications):
                tableView.performBatchUpdates({
                  // tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                       // with: .automatic)
                   tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                   // tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     //    with: .automatic)
                })
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    
    deinit {
        notificationToken?.invalidate()
    }

}
