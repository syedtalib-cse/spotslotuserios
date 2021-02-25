//
//  AppointmentRequestedVC.swift
//  Spotslot
//
//  Created by Sunil Kumar on 27/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class AppointmentRequestedVC: UIViewController {
    
    @IBOutlet weak var lblMessage:UILabel!
    
    var vendorName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMessage.text = "Awaiting confirmation from \(vendorName)"
    }
    

    @IBAction func btnDone(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
