//
//  VeryfyOTPVC.swift
//  Spotslot
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class VeryfyOTPVC: UIViewController {

    @IBOutlet weak var txtfCode: UITextField!
    @IBOutlet weak var lblSendEmailOnMail: UILabel!
    var strEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSendEmailOnMail.text = "We sent a code to your email ‘\(strEmail)’"
        // Do any additional setup after loading the view.
    }
    
      @IBAction func btnBack(_ sender: Any) {
          self.navigationController?.popViewController(animated: true)
      }

    
    @IBAction func btnContiNue(_ sender: Any) {
        if self.txtfCode.text!.isEmpty{
                GlobalObj.showAlertVC(title: appName, message: "Please enter code", controller: self)
            }else{
                let para = getAllParameters()
                self.webServiceToveriFyOTP(para: para)
            }
        }
        
        
    func pushToResetPassword(customer_id:String)  {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        vc.customer_id = customer_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
//MARK:-Webservice calling here
extension VeryfyOTPVC{
    func getAllParameters()->[String:Any]{
        var dictParam = [String:Any]()
        dictParam[ParametersKey.code.rawValue] = self.txtfCode.text?.trimmingCharacters(in: .whitespaces)
        return dictParam
    }
    
    func webServiceToveriFyOTP(para:[String:Any]) {
        UserDataModel.webServicesToverifyOtp(params: para) { (response) in
            if response != nil{
                if response?.status == 200{
                   // self.customer_id = response?.object?.customer_id ?? ""
                  //  print("vendor_id is \(self.customer_id)")
                    print(response!)
                    self.showAnnouncement(withMessage: response?.message ?? "") {
                        self.pushToResetPassword(customer_id: response?.object?.customer_id ?? "")
                    }
                }else{
                    GlobalObj.showAlertVC(title: "Failler", message: response?.message ?? "", controller: self)
                }
            }
        }
    }
}
