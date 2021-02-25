//
//  LoginVC.swift
//  Spotslot
//
//  Created by mac on 18/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewListOFCountry: UIView!
    @IBOutlet weak var tlvLanguageList: UITableView!
    @IBOutlet weak var lblLanguageText: UILabel!
    @IBOutlet weak var imglanguageFlag: UIImageView!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var imgEye: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
    }
    //Mark:- Hide on touch on bg
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            if touch.view! == self.viewBG{
                hideAndShow(toggle: true)
                
            }
        }
        
    }
    @IBAction func btnRegister(_ sender: Any) {
      pushToRegister()
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
       pushToForGotScreen()
    }
    
    @IBAction func btnOpenLanguage(_ sender: Any) {
        hideAndShow(toggle: false)
    }
    
    
    @IBAction func btnPushToPrtnerWithSpotSlot(_ sender: Any) {
     pushToPrtnerWithSpotSlot()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let valid = validation()
        if valid.success{
            let para = getAllParameters()
            self.webserviceToSignIn(para:para)
        } else {
            GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
        }
//
    }
    
    @IBAction func btnPasswordHideAndSHow(_ sender: UIButton) {
        if !sender.isSelected{
            setImage(isVisible: true)
            sender.isSelected = true
        }else{
            setImage(isVisible: false)
            sender.isSelected = false
        }
    }
    
}

//MARK:- Custom function here
extension LoginVC{
    
    func setImage(isVisible:Bool){
           if isVisible{
               self.imgEye.image = UIImage(named: "eye")
               txtfPassword.isSecureTextEntry = false
           }else{
               txtfPassword.isSecureTextEntry = true
               self.imgEye.image = UIImage(named: "eye-hide")
           }
       }
    
    func intialConfig()  {
        self.viewLogin.layer.cornerRadius = 16
        DispatchQueue.main.async {
            self.viewListOFCountry.roundedTopLeftTopRight(width: 16, height: 16)
        }
        tlvLanguageList.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "LanguageCell")
        hideAndShow(toggle: true)
    }
    
    func pushToRegister()  {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToForGotScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToPrtnerWithSpotSlot() {
           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PartnerWithSpotslotVC") as! PartnerWithSpotslotVC
            self.navigationController?.pushViewController(vc, animated: true)
       }
    
    func hideAndShow(toggle:Bool)  {
        viewBG.isHidden = toggle
        viewListOFCountry.isHidden = toggle
    }
    
    func validation() -> (success:Bool, msg:String){
         var bool = true
         var msg = ""
         if txtfEmail.isEmpty(){
             bool = false
             msg = "Please enter email"
         } else if txtfPassword.isEmpty(){
             bool = false
             msg = "Please enter password"
         }
         return (success: bool, msg: msg)
     }

}

//MARK:- TAbleView Delegate and DataSource
extension LoginVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguageListModel.modelobj.setArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tlvLanguageList.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        if indexPath.row == 0{
            cell.viewBg.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 0.4)
        }
        let arrOdModel = LanguageListModel.modelobj.setArray()
        cell.modelObj = arrOdModel[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arrOfModel = LanguageListModel.modelobj.setArray()
        self.lblLanguageText.text = arrOfModel[indexPath.row].name
        self.imglanguageFlag.image = UIImage(named:arrOfModel[indexPath.row].imageName!)
        hideAndShow(toggle: true)
        let cell = tlvLanguageList.cellForRow(at: indexPath) as! LanguageCell
         cell.viewBg.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 0.4)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tlvLanguageList.cellForRow(at: indexPath) as! LanguageCell
        cell.viewBg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
//MARK:-   Webservice Calling
extension LoginVC{
    
    func getAllParameters()->[String:Any]{
        var dictParam = [String:Any]()
        dictParam[SignUpPara.device_id] = "dhbfshbqhsbd "
        dictParam[SignUpPara.device_type] = "iOS"
        dictParam[SignUpPara.email] = self.txtfEmail.text!
        dictParam[SignUpPara.password] = self.txtfPassword.text!
        return dictParam
    }
    
    func webserviceToSignIn(para:[String:Any]){
        UserDataModel.webServicesToSignIn(params: para) { (response) in
            if response != nil{
                if response?.status == 200{
                    UserDefaults.standard.setValue(GenralText.isLoggedIn.rawValue, forKey:GenralText.isLoggedIn.rawValue)
                   GlobalObj.setRootToDashboard()
                }else{
                    GlobalObj.showAlertVC(title: appName, message: response?.message ?? "", controller: self)
                }
            }
        }
    }
}
