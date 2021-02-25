//
//  AddPaymentVC.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class AddPaymentVC: UIViewController {

    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var bimgDropDown: UIImageView!
    
    @IBOutlet weak var txtfCardName: UITextField!
    @IBOutlet weak var txtfCardNnmber: UITextField!
    @IBOutlet weak var txtfCardHolderName: UITextField!
    @IBOutlet weak var txtfValidUpto: UITextField!
    @IBOutlet weak var txtCvcNumber: UITextField!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var imgPayIcons: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    //view
    @IBOutlet weak var viewCardNumber: UIView!
    @IBOutlet weak var viewHolderName: UIView!
    @IBOutlet weak var stackCvvValidUpto: UIStackView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var arrDropDown = Array<DropDownDataModel>()
    let dropDown = DropDown()
    var arrDayOptionValues = [String]()
    var paymentType = "1"
    var objToEdit:PaymentMethodList?
    var isForEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        
    }
    
   
//    @IBAction func toMakeCardUpto(_ sender: UITextField) {
//        if sender.text?.count == 2{
//            sender.text = sender.text!+"/"
//        }else{
//
//        }
//    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txtOpenDropDown(_ sender: UITextField) {
        dropDown.show()
    }
    
    @IBAction func btnAddPayment(_ sender: UIButton) {
        let para = getAllParameterToAddPaymentMethod()
        if self.paymentType == "1"{
            let valid = validation()
            if valid.success{
                if isForEdit{
                    self.callapitoEdit()
                }else{
                    self.webServiceToAddPaymentMethod(para: para)
                }
            } else {
                GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
            }
        }else{
            if !(self.txtfEmail.isEmpty()){
                if isForEdit{
                    callapitoEdit()
                }else{
                    self.webServiceToAddPaymentMethod(para: para)
                }
                
            }else{
                GlobalObj.showAlertVC(title:appName, message: "Please enter email ", controller: self)
            }
        }
    }
    
    func callapitoEdit()  {
        let para = getAllParameterToEditPaymentMethod(payment_method_id: self.objToEdit?.id ?? "")
        self.webServiceToEditPaymentMethod(para: para)
    }
}

/*
 "id": "10",
 "user_id": "10",
 "payment_type": "2",
 "payment_method": "Apple Pay",
 "card_number": null,
 "card_holder_name": null,
 "card_valid_true": null,
 "card_cvv": null,
 "email": "sunilkumarsah6@gmail.com",
 "created_at": "2020-11-02 04:52:20",
 "updated_at": null,
 "deleted_at": null
 
 */
//MARK:- Custom function here
extension AddPaymentVC{
    func initialConfig(){
        DispatchQueue.main.async {
            self.viewTopBG.roundedTop(width: 16, height: 16)
        }
    //self.txtfValidUpto.delegate = self
        viewEmail.isHidden = true
        createDaysOptionDropDown()
        if self.isForEdit{
            btnSubmit.setTitle("Edit Payment Method", for: .normal)
            self.lblTitle.text = "Edit Payment Method"
            setDataWhileEditing()
        }else{
            self.lblTitle.text = "Add Payment Method"
            btnSubmit.setTitle("Add Payment Method", for: .normal)
        }
    }
    
    func setDataWhileEditing()  {
        if objToEdit != nil{
            paymentType = (objToEdit?.payment_type ?? "")
            if (objToEdit?.payment_type ?? "") == "2"{
                self.hideAndShowForPaymentType(toggle: true, toggleForEmail: false)
            }else if (objToEdit?.payment_type ?? "") == "3"{
                self.hideAndShowForPaymentType(toggle: true, toggleForEmail: false)
            }else {
               self.hideAndShowForPaymentType(toggle: false, toggleForEmail: true)
            }
            self.txtfCardName.text = objToEdit?.payment_method ?? ""
            self.txtfCardHolderName.text = objToEdit?.card_holder_name ?? ""
            self.txtfEmail.text = objToEdit?.email ?? ""
            self.txtfValidUpto.text = objToEdit?.card_valid_true ?? ""
            self.txtCvcNumber.text = objToEdit?.card_cvv ?? ""
            self.txtfCardNnmber.text = objToEdit?.card_number ?? ""
        }
    }
    
    
}
//MARK:- Drop Down
extension AddPaymentVC{
    func createDaysOptionDropDown()
    {
        arrDayOptionValues = ["Credit/Debit Card","Apple Pay","Google Pay"]
        for i in 0...arrDayOptionValues.count-1
        {
            txtfCardName.text = arrDayOptionValues[0]
            setupDayOptionDropDown()
            let dataModel = DropDownDataModel()
            var dict = [String:Any]()
            dict["name"] = "\(arrDayOptionValues[i])"
            dict["id"] = i+1
            dataModel.dataObject = dict as AnyObject
            dataModel.item = "\(arrDayOptionValues[i])"
            arrDropDown.append(dataModel)
        }
        setupDayOptionDropDown()
        dropDown.dataSource = arrDropDown
    }
    
    func setupDayOptionDropDown() {
        dropDown.anchorView = txtfCardName
        dropDown.bottomOffset = CGPoint(x: 0, y: txtfCardName.bounds.height/2)//
        dropDown.selectionAction = { [weak self] (index, item) in
            let dict = item.dataObject as! Dictionary<String, AnyObject>
            let value = dict["name"]
            let strValue = value as! String?
            self!.txtfCardName.text = strValue
            self!.txtfCardName.resignFirstResponder()
            switch (strValue) {
            case CardMthod.Google_Pay.rawValue:
                self?.paymentType = "3"
                self?.hideAndShowForPaymentType(toggle:true,toggleForEmail:false)
                self?.imgPayIcons.image = UIImage(named: "logos_google-pay")
                break
            case CardMthod.Apple_pay.rawValue:
                self?.paymentType = "2"
                self?.hideAndShowForPaymentType(toggle:true,toggleForEmail:false)
                 self?.imgPayIcons.image = UIImage(named: "apple_pay")
                break
            case CardMthod.Credit_Debit_Card.rawValue:
                self?.paymentType = "1"
                self?.hideAndShowForPaymentType(toggle:false,toggleForEmail:true)
                break
            default:
                print("something else")
            }
        }
    }
  
    func hideAndShowForPaymentType(toggle:Bool,toggleForEmail:Bool) {
        self.viewEmail.isHidden = toggleForEmail
        self.viewCardNumber.isHidden = toggle
        self.viewHolderName.isHidden = toggle
        self.stackCvvValidUpto.isHidden = toggle
    }
    
    
}

//MARK:- Webservice calling here -
extension AddPaymentVC{
    func validation() -> (success:Bool, msg:String){
           var bool = true
           var msg = ""
           if txtCvcNumber.isEmpty(){
               bool = false
               msg = "Please enter card number"
           } else if txtfCardName.isEmpty(){
               bool = false
               msg = "Please enter card name"
           }else if txtfValidUpto.isEmpty(){
               bool = false
               msg = "Please enter valid upto"
           }else if txtCvcNumber.isEmpty(){
               bool = false
               msg = "Please enter CVV number "
           }
           return (success: bool, msg: msg)
       }
    func webServiceToAddPaymentMethod(para:[String:Any]){
         UserDataModel.webServicesToAddPaymentMethod(params: para) { (response) in
            if response != nil{
                self.showAnnouncement(withMessage:response?.message ?? "") {
                self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func webServiceToEditPaymentMethod(para:[String:Any]){
            UserDataModel.webServicesToEditPaymentMethod(params: para) { (response) in
               if response != nil{
                   self.showAnnouncement(withMessage:response?.message ?? "") {
                   self.navigationController?.popViewController(animated: true)
                   }
               }
           }
       }
    
    func getAllParameterToAddPaymentMethod() ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.type.rawValue] = self.paymentType
        para[ParametersKey.payment_method.rawValue] = self.txtfCardName.text!
        para[ParametersKey.card_number.rawValue] = txtfCardNnmber.text
        para[ParametersKey.card_holder_name.rawValue] = txtfCardHolderName.text
        para[ParametersKey.card_valid_true.rawValue] = txtfValidUpto.text
        para[ParametersKey.card_cvv.rawValue] = txtCvcNumber.text
        para[ParametersKey.email.rawValue] = txtfEmail.text
        return para
    }
    
    func getAllParameterToEditPaymentMethod(payment_method_id:String) ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.type.rawValue] = self.paymentType
        para[ParametersKey.payment_method_id.rawValue] = payment_method_id
        para[ParametersKey.payment_method.rawValue] = self.txtfCardName.text!
        para[ParametersKey.card_number.rawValue] = txtfCardNnmber.text
        para[ParametersKey.card_holder_name.rawValue] = txtfCardHolderName.text
        para[ParametersKey.card_valid_true.rawValue] = txtfValidUpto.text
        para[ParametersKey.card_cvv.rawValue] = txtCvcNumber.text
        para[ParametersKey.email.rawValue] = txtfEmail.text
        return para
    }
    
    /*
     type:1
     payment_method:Credit Card/Debit Card
     card_number:4242 4242 5252 5454
     card_holder_name:Mr. Neetish Agrawal
     card_valid_true:05/24
     card_cvv:123
     email:neetish@yopmail.com
     payment_method_id:1
     */
    
}
