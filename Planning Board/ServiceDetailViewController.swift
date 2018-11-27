//
//  ServiceDetailViewController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 10/31/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ServiceDetailViewController: PBViewController, UITableViewDelegate, UITableViewDataSource {
    
    var service: Service!
    let cellID: String = "ComponentCell"
  
    let serviceType: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let serviceDate: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let componentTable: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    init(service: Service) {
        super.init(nibName: nil, bundle: nil)
        self.service = service
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.service.title
        [serviceType, serviceDate, componentTable].forEach { self.view.addSubview($0) }
        serviceType.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil)
        
        componentTable.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        componentTable.delegate = self
        componentTable.dataSource = self
        componentTable.register(ComponentCell.self, forCellReuseIdentifier: cellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.components?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard service.components != nil else { return UITableViewCell() }
        return ComponentCell(productItem: service.components![indexPath.row], reuseIdentifier: cellID)
    }
}
