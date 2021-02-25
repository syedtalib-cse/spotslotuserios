//
//  RootViewController.swift
//  REFrostedViewControllerSwiftExample
//
//  Created by Benny Singer on 5/20/17.
//  Copyright © 2017 Benny Singer. All rights reserved.
//

import UIKit
import REFrostedViewController

class RootViewController: REFrostedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "JBTabBarController")
        self.menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController")
        // Do any additional setup after loading the view.
    }


    
}
