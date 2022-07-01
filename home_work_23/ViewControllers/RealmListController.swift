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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRequest.delegate = self
        tableViewRequest.dataSource = self
        tableViewRequest.register(UINib(nibName: "ListRequestTableCell", bundle: nil), forCellReuseIdentifier: ListRequestTableCell.key)
        provaider = RealmProvader()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableViewRequest.reloadData()
    }
}
