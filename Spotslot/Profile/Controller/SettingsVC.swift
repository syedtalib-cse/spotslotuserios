//
//  SettingsVC.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
 
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var tlvSettingsList: UITableView!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewLanguageList: UIView!
    @IBOutlet weak var tlvLanguageList: UITableView!
    
    var arrTitle = [String]()
    var notification_status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        storeData()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOpenLanguageList(_ sender:Any){
        self.hideAndShow(toggle: false)
    }
    
    @IBAction func toOnOFNotification(_ sender: UISwitch) {
        if sender.isOn{
         toOnOfNotification(status: "1")
        }else{
         toOnOfNotification(status: "0")
        }
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
}

//MARK:- Custom function here
extension SettingsVC{
    func initialConfig(){
        DispatchQueue.main.async {
            self.viewTopBG.roundedTop(width: 16, height: 16)
            
        }
        self.navigationController?.setNavigationBarHidden(true, animated:true)
        storeData()
        self.tlvSettingsList.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
        tlvLanguageList.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "LanguageCell")
        self.hideAndShow(toggle: true)
        if notification_status == "1"{
            self.notificationSwitch.isOn = true
        }else{
            self.notificationSwitch.isOn = false
        }
    }
    func storeData(){
        arrTitle = ["Edit Profile","Change Password","Edit Contact Details","Edit Address List","Edit Payment Details"]
        self.tlvSettingsList.reloadData()
    }
    
    func hideAndShow(toggle:Bool)  {
        self.viewBG.isHidden = toggle
        self.viewLanguageList.isHidden = toggle
    }
    
    func toOnOfNotification(status:String)  {
        UserDataModel.webServicesToOnOFNotification(params: ["status":status]) { (response) in
            if response != nil{
                if (response?.objNotifictaion?.notification_status ?? "") == "1"{
                    self.notificationSwitch.isOn = true
                }else{
                     self.notificationSwitch.isOn = true
                }
            }
        }
    }
    
}
//MARK:- Delegate and DataSource Methods Of TableView
extension SettingsVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.self.tlvSettingsList{
            DispatchQueue.main.async{
                self.heightOfTableView.constant = self.tlvSettingsList.contentSize.height
            }
            return self.arrTitle.count
        }else{
            return LanguageListModel.modelobj.setArray().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.tlvLanguageList != tableView{
            let cell = self.tlvSettingsList.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
            cell.lblTitle.text = self.arrTitle[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tlvLanguageList.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
            if indexPath.row == 0{
                cell.viewBg.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 0.4)
            }
            let arrOdModel = LanguageListModel.modelobj.setArray()
            cell.modelObj = arrOdModel[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.tlvSettingsList == tableView{
            if indexPath.row == 0{
                let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1{
                let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ChanegPasswordVC") as! ChanegPasswordVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 2{
                
            }else if indexPath.row == 3{
                let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "EditAddressVC") as! EditAddressVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 4{
                let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PaymentListVC") as! PaymentListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else{
            self.hideAndShow(toggle: true)
        }
        
    }
}
