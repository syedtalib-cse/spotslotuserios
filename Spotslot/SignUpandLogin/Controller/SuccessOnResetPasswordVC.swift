//
//  SuccessOnResetPasswordVC.swift
//  Spotslot
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class SuccessOnResetPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnPushTologin(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
