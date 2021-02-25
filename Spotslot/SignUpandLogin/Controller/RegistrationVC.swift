//
//  RegistrationVC.swift
//  Spotslot
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnRegister: UIButton!
    
    //TextField
    @IBOutlet weak var txtfFirstName: UITextField!
    @IBOutlet weak var txtfLastName: UITextField!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var txtfDateOfBirthday: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var imgEye: UIImageView!
    @IBOutlet weak var txtFrefeeralCode: UITextField!
    
   
    
    //radio buttons img
    @IBOutlet weak var imgNotTosay: UIImageView!
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!
    
    //MARK:- Class variable
    var datePicker = UIDatePicker()
     var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
        createDatePicker()
    }
    
    @IBAction func btnAlreadyHaveAnAccount(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
     self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func xttfOpenDateCalandar(_ sender: UITextField) {
    }
    
    @IBAction func btnFemale(_ sender: Any) {
        resetImg()
        imgFemale.image = UIImage(named: "services_radio_btn")
        gender = Gender.female.rawValue
        print("gender is \(gender)")
    }
    
    @IBAction func btnMale(_ sender: Any) {
        resetImg()
        imgMale.image = UIImage(named: "services_radio_btn")
        gender = Gender.male.rawValue
         print("gender is \(gender)")
        
    }
    
    @IBAction func btnNotToSay(_ sender: Any) {
        resetImg()
        imgNotTosay.image = UIImage(named: "services_radio_btn")
        gender = Gender.other.rawValue
         print("gender is \(gender)")
    }
    
    
    @IBAction func btnRegister(_ sender: Any) {
        let valid = validation()
        if valid.success {
            let para = getAllParameters()
            self.webserviceToSignUp(para: para)
        } else {
            GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
        }
    }
    
    @IBAction func btnPasswordHideAndShow(_ sender: UIButton) {
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
extension RegistrationVC{
    func intialConfig()  {
        DispatchQueue.main.async {
            self.bgView.roundedTopLeftTopRight(width: 20, height: 20 )//roundedTop(
            //self.btnRegister.layer.cornerRadius =  16
        }
       
    }
    func validation() -> (success:Bool, msg:String){
        self.txtfEmail.text = self.txtfEmail.text?.trimmingCharacters(in: .whitespaces)
         var bool = true
         var msg = ""
         if txtfFirstName.isEmpty() {
             bool = false
             msg = "Please enter first name"
         } else if txtfLastName.isEmpty() {
             bool = false
             msg = "Please enter last name"
         }else if txtfEmail.isEmpty() {
             bool = false
             msg = "Please enter email address"
         }else if !txtfEmail.isValidEmail() {
             bool = false
             msg = "Please enter valid email address"
         } else if txtfDateOfBirthday.isEmpty() {
             bool = false
             msg = "Please date of birth"
         } else if txtfPassword.isEmpty() {
             bool = false
             msg = "Please enter password"
         }else if gender == ""{
            //
            bool = false
            msg = "Please select your gender"
        }
         return (success: bool, msg: msg)
     }
    
    func setImage(isVisible:Bool){
        if isVisible{
            self.imgEye.image = UIImage(named: "eye")
            txtfPassword.isSecureTextEntry = false
        }else{
            txtfPassword.isSecureTextEntry = true
            self.imgEye.image = UIImage(named: "eye-hide")
        }
    }
    
    func createDatePicker()  {
         datePicker.datePickerMode = .date
         let toolBar = UIToolbar()
         toolBar.barStyle = .default
         toolBar.isTranslucent = true
         toolBar.isUserInteractionEnabled = true
         datePicker.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9490196078, blue: 0.9960784314, alpha: 1)
         let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         self.datePicker.setValue(textColor, forKey: "textColor")
         toolBar.sizeToFit()
         let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(donetoShowDate))
         doneBarButton.tintColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
         toolBar.setItems([doneBarButton], animated: false)
         txtfDateOfBirthday.inputAccessoryView = toolBar
         txtfDateOfBirthday.inputView = datePicker
     }
     
     @objc func donetoShowDate()  {
        let dateformater = DateFormatter()
         dateformater.dateFormat = dateOfBirthFormate
         let str = dateformater.string(from: datePicker.date)
         txtfDateOfBirthday.text = str
         self.view.endEditing(true)
     }
    func resetImg(){
        imgNotTosay.image = UIImage(named: "radio-button")
        imgMale.image = UIImage(named: "radio-button")
        imgFemale.image = UIImage(named: "radio-button")
    }
}

/*
 first_name:Priya
 last_name:Sharma
 email:fgq@yopmail.com
 dob:June 20 1992
 password:12345678
 device_id:1dfgfdgfd
 device_type:IOS
 referal_code:abc
 
 */

//MARK:-   Webservice Calling
extension RegistrationVC{
    func getAllParameters()->[String:Any]{
        var dictParam = [String:Any]()
        dictParam[SignUpPara.device_id] = "dhbfshbqhsbd "
        dictParam[SignUpPara.device_type] = "iOS"
        dictParam[SignUpPara.dob] = self.txtfDateOfBirthday.text
        dictParam[SignUpPara.email] = self.txtfEmail.text
        dictParam[SignUpPara.first_name] = self.txtfFirstName.text?.trimmingCharacters(in: .whitespaces)
        dictParam[SignUpPara.last_name] = self.txtfLastName.text?.trimmingCharacters(in: .whitespaces)
        dictParam[SignUpPara.password] = self.txtfPassword.text?.trimmingCharacters(in: .whitespaces)
        dictParam[SignUpPara.referal_code] = self.txtFrefeeralCode.text?.trimmingCharacters(in: .whitespaces)
        dictParam[ParametersKey.gender.rawValue] = self.gender
        return dictParam
    }
    
    func webserviceToSignUp(para:[String:Any]) {
        UserDataModel.webServicesToSignUp(params: para) { (response) in
            if response != nil{
                if response?.status == 200{
                    self.showAnnouncement(withMessage: response?.message ?? "", closer:{
                       // self.navigationController?.popViewController(animated: true)
                        GlobalObj.setRootToDashboard()
                    })
                }else{
                    GlobalObj.showAlertVC(title: "Failler", message: response?.message ?? "", controller: self)
                }
            }
        }
    }
}
