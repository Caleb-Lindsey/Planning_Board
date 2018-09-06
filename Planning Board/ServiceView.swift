//
//  LandingView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import MessageUI

class ServiceView: PBViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    private let cellId: String = "serviceCell"
    
    let serviceTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Services"
        
        [serviceTableView].forEach { self.view.addSubview($0) }
        serviceTableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        serviceTableView.delegate = self
        serviceTableView.dataSource = self
        serviceTableView.register(ServiceCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.arrayOfServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thisService: Service = Global.arrayOfServices[indexPath.row]
        let cell: ServiceCell = ServiceCell(service: thisService, reuseIdentifier: cellId)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
