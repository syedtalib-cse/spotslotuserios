//
//  ResetPasswordVC.swift
//  Spotslot
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var txtfNewPassword: UITextField!
    @IBOutlet weak var txtfConfirmPassword: UITextField!
    @IBOutlet weak var imgConfimPassword: UIImageView!
    @IBOutlet weak var imgNewPassword: UIImageView!
    
    var customer_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnHideNshowNewPassword(_ sender: UIButton) {
          if !sender.isSelected{
              setImageForNewPassword(isVisible: true)
              sender.isSelected = true
          }else{
              setImageForNewPassword(isVisible: false)
              sender.isSelected = false
          }
      }
      @IBAction func btnhideNShowConfirmPAssword(_ sender: UIButton) {
          if !sender.isSelected{
              setImageForRepeatPassword(isVisible: true)
              sender.isSelected = true
          }else{
              setImageForRepeatPassword(isVisible: false)
              sender.isSelected = false
          }
      }
    
    
    

    @IBAction func btnPushToSuccess(_ sender: Any) {
        let valid = validation()
        if valid.success {
            let para = getAllParameters()
            self.webserviceToResetPassword(para:para)
        } else {
            GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
        }
    }
    
    func pushToSuccessScreen()  {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessOnResetPasswordVC") as! SuccessOnResetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func validation() -> (success:Bool, msg:String){
           var bool = true
           var msg = ""
           if txtfNewPassword.isEmpty() {
               bool = false
               msg = "Please enter new password"
           } else if txtfConfirmPassword.isEmpty() {
               bool = false
               msg = "Please enter confirm password"
           }else if txtfNewPassword.text! != txtfConfirmPassword.text!{
               bool = false
               msg = "Password does not match"
           }else if txtfNewPassword.text!.count < 6{
               bool = false
               msg = "Password should be greater than 6 character"
           }
           return (success: bool, msg: msg)
       }
    
    func setImageForNewPassword(isVisible:Bool){
           if isVisible{
               self.imgNewPassword.image = UIImage(named: "eye")
               txtfNewPassword.isSecureTextEntry = false
           }else{
               txtfNewPassword.isSecureTextEntry = true
               self.imgNewPassword.image = UIImage(named: "eye-hide")
           }
       }
       
       func setImageForRepeatPassword(isVisible:Bool){
           if isVisible{
               self.imgConfimPassword.image = UIImage(named: "eye")
               txtfConfirmPassword.isSecureTextEntry = false
           }else{
               txtfConfirmPassword.isSecureTextEntry = true
               self.imgConfimPassword.image = UIImage(named: "eye-hide")
           }
       }
    
}

//MARK:- Webservice calling here -
extension ResetPasswordVC{
    
    func getAllParameters()->[String:Any]{
        var dictParam = [String:Any]()
        dictParam[ParametersKey.new_password.rawValue] = self.txtfConfirmPassword.text!.trimmingCharacters(in: .whitespaces)
        dictParam[ParametersKey.confirm_password.rawValue] = self.txtfNewPassword.text?.trimmingCharacters(in: .whitespaces)
        dictParam[ParametersKey.customer_id.rawValue] =   self.customer_id
        return dictParam
    }
    
    func webserviceToResetPassword(para:[String:Any]){
        UserDataModel.webServicesToResetPassword(params: para) { (response) in
            if response != nil{
                if response?.status == 200{
                    self.pushToSuccessScreen()
                }else{
                    GlobalObj.showAlertVC(title:appName, message: response?.message ?? "", controller: self)
                }
            }
        }
    }
    
}

