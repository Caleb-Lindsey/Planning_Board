//
//  CustomTabBar.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/8/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class CustomTabBar : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = Global.greenColor
        self.tabBar.unselectedItemTintColor = UIColor.black
        self.tabBar.tintColor = UIColor.white
        self.tabBar.itemSpacing = 100
        
        //Setup view controllers
        let serviceController = ServiceView()
        let serviceNavController = UINavigationController(rootViewController: serviceController)
        serviceNavController.tabBarItem.title = "Services"
        serviceNavController.tabBarItem.image = UIImage(named: "service")
        
        let segmentsController = SegmentsView()
        let segmentsNavController = UINavigationController(rootViewController: segmentsController)
        segmentsNavController.tabBarItem.title = "Segments"
        segmentsNavController.tabBarItem.image = UIImage(named: "segments")
        
        let peopleController = PeopleView()
        let peopleNavController = UINavigationController(rootViewController: peopleController)
        peopleNavController.tabBarItem.title = "People"
        peopleNavController.tabBarItem.image = UIImage(named: "people")
        
        //Array of viewcontrollers
        viewControllers = [serviceNavController, segmentsNavController, peopleNavController]
    }
    
}
