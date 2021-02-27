//
//  ProfileVC.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import TextFieldEffects

class ProfileVC: UIViewController {
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewProfileInfo: UIView!
    @IBOutlet weak var viewSetting: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var txtfLanguage: HoshiTextField!
    @IBOutlet weak var txtfGender: HoshiTextField!
    @IBOutlet weak var txtfEllergy: HoshiTextField!
    @IBOutlet weak var HairCutFrequency: HoshiTextField!
    
    @IBOutlet weak var imgStyleFirst: UIImageView!
    @IBOutlet weak var imgStyleSecond: UIImageView!
    @IBOutlet weak var imgStyleThird: UIImageView!
    @IBOutlet weak var btnremaining: UIButton!
    
    var favorite_styles : [Favorite_styles]?
    var notification_status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfig()
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
       webServicesToGetProfileData()
    }
    
    
    @IBAction func btnPushToSetting(_ sender: Any) {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        vc.notification_status = self.notification_status
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPushToEditProfile(_ sender: Any) {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
//MARK:- Custom function here
extension ProfileVC{
    func initialConfig(){
        DispatchQueue.main.async {
            self.viewTop.roundedTop(width: 16, height: 16)
            self.viewProfileInfo.roundedTop(width: 16, height: 16)
        }
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
        self.navigationController?.setNavigationBarHidden(true, animated:true)
       
    }
    
    func webServicesToGetProfileData() {
        UserDataModel.webServicesToGetCustomerData(params: [:]) { (response) in
            if response != nil{
                self.setData(response: response!)
            }
        }
    }
    
    func setData(response:UserDataModel){
        imgProfile.sd_setImage(with: URL(string: response.objCustomerData?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        lblName.text = response.objCustomerData?.name ?? ""
        notification_status = response.objCustomerData?.notification_status ?? ""
        //txtfLanguage.text = response.objCustomerData?.language_know ?? ""
        txtfGender.text = "Male"
        txtfEllergy.text = response.objCustomerData?.allergies ?? ""
        HairCutFrequency.text = response.objCustomerData?.haircut_freuency ?? ""
        /*if (response.objCustomerData?.favorite_styles!.count ?? 0)>3{
            imgStyleFirst.sd_setImage(with: URL(string: response.objCustomerData?.favorite_styles?.first?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            imgStyleSecond.sd_setImage(with: URL(string: response.objCustomerData?.favorite_styles?[1].image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            imgStyleThird.sd_setImage(with: URL(string: response.objCustomerData?.favorite_styles?[1].image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            btnremaining.setTitle("\((response.objCustomerData?.favorite_styles!.count ?? 0)-3)+", for: .normal)
        }else{
            
        }*/
        
        let selectedLanguagesNames = response.objCustomerData?.language_know?.reduce([String](), { (result, language) -> [String] in
            var _result = result
            if language.languageName != nil {
                _result.append(language.languageName ?? "")
            }
            
            return _result
        }).joined(separator: ", ")
        self.txtfLanguage.text = selectedLanguagesNames
        
        if let favStyles = response.objCustomerData?.favorite_styles {
            for (index, style) in favStyles.enumerated() {
                if index == 0 {
                    imgStyleFirst.sd_setImage(with: URL(string: style.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
                } else if index == 1 {
                    imgStyleSecond.sd_setImage(with: URL(string: style.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }else if index == 2 {
                    imgStyleThird.sd_setImage(with: URL(string: style.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
                    if favStyles.count > 3 {
                        btnremaining.setTitle("\(favStyles.count - 3)+", for: .normal)
                    }
                }
            }
        }
   
    }
    
}

