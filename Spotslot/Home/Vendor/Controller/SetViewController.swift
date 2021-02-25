//
//  SetViewController.swift
//  Spotslot
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
