//
//  ForgotPasswordVC.swift
//  Spotslot
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txtfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendCode(_ sender: Any) {
        if txtfEmail.text  != ""{
            let para = getAllParameters()
            self.webserviceToForgotPassword(para: para)
        }else{
             GlobalObj.showAlertVC(title:appName, message: "Please enter email", controller: self)
        }
    }
    
}

//MARK:- Custom function here
extension ForgotPasswordVC{
    func pushToVeriFyScreen()  {
     let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VeryfyOTPVC") as! VeryfyOTPVC
        vc.strEmail = self.txtfEmail.text?.trimmingCharacters(in: .whitespaces) ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//MARK:-Webservice calling here
extension ForgotPasswordVC{
    func getAllParameters()->[String:Any]{
        var dictParam = [String:Any]()
        dictParam[SignUpPara.email] = self.txtfEmail.text?.trimmingCharacters(in: .whitespaces)
        return dictParam
    }
    
    func webserviceToForgotPassword(para:[String:Any]) {
        UserDataModel.webServicesToForgotPassword(params: para) { (response) in
            if response != nil{
                if response?.status == 200{
                    self.showAnnouncement(withMessage: response?.message ?? "") {
                    self.pushToVeriFyScreen()
                    }
                }else{
                    GlobalObj.showAlertVC(title: "Failler", message: response?.message ?? "", controller: self)
                }
            }
        }
    }
}
