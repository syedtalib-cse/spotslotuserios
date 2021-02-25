//
//  RateVC.swift
//  Spotslot
//
//  Created by mac on 04/11/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import HCSStarRatingView
class RateVC: UIViewController {

    @IBOutlet weak var imgVendor: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var viewRate: HCSStarRatingView!
    
    @IBOutlet weak var btnProfesionalism: UIButton!
    @IBOutlet weak var btnPuntuation: UIButton!
    @IBOutlet weak var btnNavigation: UIButton!
    @IBOutlet weak var btnConversation: UIButton!
    @IBOutlet weak var PersonalHygiene: UIButton!
    @IBOutlet weak var btnServiceQuality: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    
    @IBOutlet weak var txtfTip: UITextField!
    @IBOutlet weak var txtfTypeHere: UITextField!
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewBottom: UIView!
    
    
    @IBOutlet weak var imgVendors: UIImageView!
    @IBOutlet weak var lblUserNameOnPopUp: UILabel!
    @IBOutlet weak var lblVendorame: UILabel!
    
    @IBOutlet weak var lblTipAmount: UILabel!
    
    
    var objPrevious :Previous?
    
    var idsForQuality = [String]()
    var nameForQuality = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.viewTop.roundedTop(width: 16, height: 16)
            self.viewBottom.roundedTop(width: 16, height: 16)
        }
        setData()
        closeView(toggle: true)
    }
    
   
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPro(_ sender: UIButton) {
        self.setColor(self.btnProfesionalism)
    }
    
    @IBAction func btnPun(_ sender: UIButton) {
        self.setColor(self.btnPuntuation)
    }
    
    @IBAction func btnNavigation(_ sender: UIButton) {
        self.setColor(self.btnNavigation)
    }
    
    @IBAction func btnConver(_ sender: UIButton) {
        self.setColor(self.btnConversation)
    }
    
    @IBAction func bntHygiene(_ sender: UIButton) {
        self.setColor(self.PersonalHygiene)
    }
    
    @IBAction func btnOther(_ sender: UIButton) {
        self.setColor(self.btnOther)
    }
    
    @IBAction func btnServiceQuality(_ sender: UIButton) {
        self.setColor(self.btnServiceQuality)
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        closeView(toggle:true)
    }
    
    
    @IBAction func btnRate(_ sender: Any) {
        if !txtfTip.isEmpty(){
            self.lblTipAmount.text = "\(GenralText.currency.rawValue) "+self.txtfTip.text!
         closeView(toggle:false)
        }else{
            let valid = validation()
            if valid.success{
                let para = getAllParameter()
                self.webServiceToRateTheVendor()
            } else {
                GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
            }
        }
          
    }
    
    @IBAction func btnRateandTip(_ sender: Any) {
        let valid = validation()
        if valid.success{
            let para = getAllParameter()
            self.webServiceToRateTheVendor()
        } else {
            GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
        }
    }

    func closeView(toggle:Bool)  {
        viewBackground.isHidden = toggle
        viewBottom.isHidden = toggle
    }
    
    func setColor(_ sender:UIButton){
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        setBgColorButtton(sender:sender)
    }
    
}

//MARK:- Webservice calling here -
extension RateVC{

    func webServiceToRateTheVendor()  {
        let para = getAllParameter()
        UserDataModel.webServiceToRateToVendor(params: para) { (response) in
            if response != nil{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func getAllParameter() ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.rating.rawValue] = viewRate.value
        let ids = self.idsForQuality.joined(separator: ",")
        para[ParametersKey.quality_service_id.rawValue] = ids
        let names = self.nameForQuality.joined(separator: ",")
        para[ParametersKey.quality_service_name.rawValue] = names
        para[ParametersKey.vendor_id.rawValue] = objPrevious?.vendor_id ?? ""
        para[ParametersKey.tip.rawValue] = self.txtfTip.text!
        return para
    }
    
    func validation() -> (success:Bool, msg:String){
          var bool = true
          var msg = ""
        if viewRate.value == 0{
              bool = false
              msg = "Please rate to this vendor"
        }else if self.nameForQuality.count == 0{
              bool = false
              msg = "Please enter password"
        }else if self.txtfTypeHere.isEmpty(){
              bool = false
              msg = "Please share your experience"
          }
          return (success: bool, msg: msg)
      }
    
    /*
     rating:3
     quality_service_id:1
     quality_service_name:Profesionalism
     review:Type here your comment...
     vendor_id:20
     tip:75
     */

    func setData(){
        if self.objPrevious != nil{
            
            imgVendor.sd_setImage(with: URL(string:objPrevious?.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            print("profile image url is \(objPrevious?.vendor_image ?? "")")
            lblUserName.text = objPrevious?.username ?? ""
            lblVendorName.text = objPrevious?.vendor_name ?? ""
            imgVendors.sd_setImage(with: URL(string:objPrevious?.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            lblUserNameOnPopUp.text = objPrevious?.username ?? ""
            lblVendorame.text = objPrevious?.vendor_name ?? ""
        }
    }
    
    
    func setBgColorButtton(sender:UIButton){
        let coro1 = #colorLiteral(red: 0.2509803922, green: 0.4039215686, blue: 0.7568627451, alpha: 1)
        if sender == btnProfesionalism{
            if !btnProfesionalism.isSelected{
                btnProfesionalism.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9960784314, alpha: 1)
                btnProfesionalism.setTitleColor(coro1, for: .normal)
                if self.idsForQuality.contains("\(btnProfesionalism.tag)"){
                    self.idsForQuality.remove(at: idsForQuality.firstIndex(of: "\(btnProfesionalism.tag)")!)
                }
                
                if self.nameForQuality.contains((btnProfesionalism.titleLabel?.text!)!){
                    self.nameForQuality.remove(at: nameForQuality.firstIndex(of:btnProfesionalism.titleLabel!.text!)!)
                }
            }else{
                btnProfesionalism.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                btnProfesionalism.setTitleColor(.white, for: .normal)
                self.idsForQuality.append("\(btnProfesionalism.tag)")
                self.nameForQuality.append((btnProfesionalism.titleLabel?.text!)!)
            }
        }
        
        if sender == btnPuntuation{
            if !btnPuntuation.isSelected{
                btnPuntuation.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9960784314, alpha: 1)
                btnPuntuation.setTitleColor(coro1, for: .normal)
                if self.idsForQuality.contains("\(btnPuntuation.tag)"){
                    self.idsForQuality.remove(at: idsForQuality.firstIndex(of: "\(btnPuntuation.tag)")!)
                }
                if self.nameForQuality.contains((btnPuntuation.titleLabel?.text!)!){
                    self.nameForQuality.remove(at: nameForQuality.firstIndex(of:btnPuntuation.titleLabel!.text!)!)
                }
            }else{
                btnPuntuation.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                btnPuntuation.setTitleColor(.white, for: .normal)
                self.idsForQuality.append("\(btnPuntuation.tag)")
                self.nameForQuality.append((btnPuntuation.titleLabel?.text!)!)
                
            }
        }
        
        if sender == btnNavigation{
            if !btnNavigation.isSelected{
                btnNavigation.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9960784314, alpha: 1)
                btnNavigation.setTitleColor(coro1, for: .normal)
                if self.idsForQuality.contains("\(btnNavigation.tag)"){
                    self.idsForQuality.remove(at: idsForQuality.firstIndex(of: "\(btnNavigation.tag)")!)
                }
                
                if self.nameForQuality.contains((btnNavigation.titleLabel?.text!)!){
                    self.nameForQuality.remove(at: nameForQuality.firstIndex(of:btnNavigation.titleLabel!.text!)!)
                }
            }else{
                btnNavigation.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                btnNavigation.setTitleColor(.white, for: .normal)
                self.idsForQuality.append("\(btnNavigation.tag)")
                self.nameForQuality.append((btnNavigation.titleLabel?.text!)!)
            }
        }
        
        if sender == btnConversation{
            if !btnConversation.isSelected{
                btnConversation.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9960784314, alpha: 1)
                btnConversation.setTitleColor(coro1, for: .normal)
                if self.idsForQuality.contains("\(btnConversation.tag)"){
                    self.idsForQuality.remove(at: idsForQuality.firstIndex(of: "\(btnConversation.tag)")!)
                }
                if self.nameForQuality.contains((btnConversation.titleLabel?.text!)!){
                    self.nameForQuality.remove(at: nameForQuality.firstIndex(of:btnConversation.titleLabel!.text!)!)
                }
            }else{
                btnConversation.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                btnConversation.setTitleColor(.white, for: .normal)
                self.idsForQuality.append("\(btnConversation.tag)")
                 self.nameForQuality.append((btnConversation.titleLabel?.text!)!)
            }
        }
        if sender == PersonalHygiene{
            if !PersonalHygiene.isSelected{
                PersonalHygiene.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9960784314, alpha: 1)
                PersonalHygiene.setTitleColor(coro1, for: .normal)
                if self.idsForQuality.contains("\(PersonalHygiene.tag)"){
                    self.idsForQuality.remove(at: idsForQuality.firstIndex(of: "\(PersonalHygiene.tag)")!)
                }
                
                if self.nameForQuality.contains((PersonalHygiene.titleLabel?.text!)!){
                    self.nameForQuality.remove(at: nameForQuality.firstIndex(of:PersonalHygiene.titleLabel!.text!)!)
                }
            }else{
                PersonalHygiene.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                PersonalHygiene.setTitleColor(.white, for: .normal)
                self.idsForQuality.append("\(PersonalHygiene.tag)")
                 self.nameForQuality.append((PersonalHygiene.titleLabel?.text!)!)
            }
        }
        
        if sender == btnServiceQuality{
            if !btnServiceQuality.isSelected{
                btnServiceQuality.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9960784314, alpha: 1)
                btnServiceQuality.setTitleColor(coro1, for: .normal)
                if self.idsForQuality.contains("\(btnServiceQuality.tag)"){
                self.idsForQuality.remove(at: idsForQuality.firstIndex(of: "\(btnServiceQuality.tag)")!)
                }
                
                if self.nameForQuality.contains((btnServiceQuality.titleLabel?.text!)!){
                    self.nameForQuality.remove(at: nameForQuality.firstIndex(of:btnServiceQuality.titleLabel!.text!)!)
                }
                
                
            }else{
                btnServiceQuality.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                btnServiceQuality.setTitleColor(.white, for: .normal)
                self.idsForQuality.append("\(btnServiceQuality.tag)")
                   self.nameForQuality.append((btnServiceQuality.titleLabel?.text!)!)
            }
        }
        
        if sender == btnOther{
            if !btnOther.isSelected{
                btnOther.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9960784314, alpha: 1)
                btnOther.setTitleColor(coro1, for: .normal)
                if self.idsForQuality.contains("\(btnOther.tag)"){
                self.idsForQuality.remove(at: idsForQuality.firstIndex(of: "\(btnOther.tag)")!)
                }
                
                if self.nameForQuality.contains((btnOther.titleLabel?.text!)!){
                    self.nameForQuality.remove(at: nameForQuality.firstIndex(of:btnOther.titleLabel!.text!)!)
                }
                
            }else{
                btnOther.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                btnOther.setTitleColor(.white, for: .normal)
                self.idsForQuality.append("\(btnOther.tag)")
                 self.nameForQuality.append((btnOther.titleLabel?.text!)!)
            }
        }
        
        print("ids are \(self.idsForQuality)")
            print("ids are \(self.nameForQuality)")
}
}
