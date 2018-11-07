//
//  ServiceDetailViewController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 10/31/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ServiceDetailViewController: PBViewController {
    
    var service: Service!
  
    let serviceType: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let serviceDate: UILabel = {
        let label = UILabel()
        return label
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
        [serviceType, serviceDate].forEach { self.view.addSubview($0) }
    }
}
