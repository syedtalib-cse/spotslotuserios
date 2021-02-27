//
//  ChanegPasswordVC.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class ChanegPasswordVC: UIViewController {

    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var txtfCurrentPassword: UITextField!
    @IBOutlet weak var txtfNewPassword: UITextField!
    @IBOutlet weak var txtfRepeatPassword: UITextField!
    
    
    @IBOutlet weak var imgCurrentPassword: UIImageView!
    @IBOutlet weak var imgNewPassword: UIImageView!
    @IBOutlet weak var imgRepeatPassword: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
       
    }
    
    
    @IBAction func btnCurrentPassShowHide(_ sender: UIButton) {
        if !sender.isSelected{
            sender.isSelected = true
            setImageCurrentPass(isVisible: true)
        }else{
            sender.isSelected = false
            setImageCurrentPass(isVisible: false)
        }
    }
    
    @IBAction func btnNewPassShowHide(_ sender: UIButton) {
        if !sender.isSelected{
            sender.isSelected = true
            setImageNewPass(isVisible: true)
        }else{
            sender.isSelected = false
            setImageNewPass(isVisible: false)
        }
    }
    @IBAction func btnRepeatPassShowHide(_ sender: UIButton) {
        if !sender.isSelected{
            sender.isSelected = true
            setImageRepeatPass(isVisible: true)
        }else{
            sender.isSelected = false
            setImageRepeatPass(isVisible: false)
        }
    }
    
    
    func setImageCurrentPass(isVisible:Bool){
        if isVisible{
            self.imgCurrentPassword.image = UIImage(named: "eye")
            txtfCurrentPassword.isSecureTextEntry = false
        }else{
            txtfCurrentPassword.isSecureTextEntry = true
            self.imgCurrentPassword.image = UIImage(named: "eye-hide")
        }
    }
    
    func setImageNewPass(isVisible:Bool){
        if isVisible{
            self.imgNewPassword.image = UIImage(named: "eye")
            txtfNewPassword.isSecureTextEntry = false
        }else{
            txtfNewPassword.isSecureTextEntry = true
            self.imgNewPassword.image = UIImage(named: "eye-hide")
        }
    }
    
    func setImageRepeatPass(isVisible:Bool){
        if isVisible{
            self.imgRepeatPassword.image = UIImage(named: "eye")
            txtfRepeatPassword.isSecureTextEntry = false
        }else{
            txtfRepeatPassword.isSecureTextEntry = true
            self.imgRepeatPassword.image = UIImage(named: "eye-hide")
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPushToLogin(_ sender: Any) {
        let valid = validation()
        if valid.success{
            self.webServicesToChangePassword()
        } else {
            GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
     self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
       
    }
    
}

//MARK:- Custom function here
extension ChanegPasswordVC{
    func intialConfig(){
        DispatchQueue.main.async{
         self.viewContainer.roundedTop(width: 16, height: 16)
        }
        if let profile_img  = SharedPreference.getUserData().profile_image{
        self.imgProfile.sd_setImage(with: URL(string:profile_img), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    func validation() -> (success:Bool, msg:String){
        var bool = true
        var msg = ""
        if txtfCurrentPassword.isEmpty(){
            bool = false
            msg = "Please enter your current password"
        } else if txtfCurrentPassword.text!.count < 6{
            bool = false
            msg = "Current password should be greater than 6 characters"
        } else if txtfNewPassword.isEmpty(){
            bool = false
            msg = "Please enter new password"
        }else if txtfNewPassword.text!.count < 6{
            bool = false
            msg = "New password should be greater than 6 characters"
        }else if txtfRepeatPassword.isEmpty(){
            bool = false
            msg = "Please enter repeat password"
        }else if txtfRepeatPassword.text!.count < 6{
            bool = false
            msg = "Repeat password should be greater than 6 characters"
        }else if txtfNewPassword.text != txtfRepeatPassword.text{
            bool = false
            msg = "Password does not match"
        }
        return (success: bool, msg: msg)
    }
    
    func getAllParameter() ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.current_password.rawValue] =  txtfCurrentPassword.text?.trimmingCharacters(in: .whitespaces)
        para[ParametersKey.new_password.rawValue] = self.txtfNewPassword.text?.trimmingCharacters(in:.whitespaces)
        para[ParametersKey.confirm_password.rawValue] = self.txtfRepeatPassword.text?.trimmingCharacters(in: .whitespaces)
        return para
    }
    
    func webServicesToChangePassword()  {
        let para = getAllParameter()
        UserDataModel.webServicesToChanegThePassword(params: para) { (response) in
            if response != nil{
                self.showAnnouncement(withMessage: response?.message ?? "") { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    
    
    
    
}
