//
//  EditProfileVC.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtfFullName: UITextField!
    @IBOutlet weak var txtfDateOfBirth: UITextField!
    @IBOutlet weak var txtfAllergies: UITextField!
    @IBOutlet weak var txtfServiceDuration: UITextField!
    @IBOutlet weak var lblLangauge: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewAddLanguage: UIView!
    @IBOutlet weak var txtfLanguage: UITextField!
    
    //var objCustomerData:CustomerDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOpenCamera(_ sender: Any) {
      toSelectImageFromGallery()
    }
    
    @IBAction func btnHideAddLanguage(_ sender: Any) {
    hideAndShow(toggle: true)
    }
    
//    @IBAction func btnAddLanguage(_ sender: Any) {
//    hideAndShow(toggle: true)
//    }
    
    func hideAndShow(toggle:Bool)  {
        viewBackground.isHidden = toggle
        viewAddLanguage.isHidden = toggle
    }
    
    @IBAction func btnAddlanguage(_ sender: Any) {
        hideAndShow(toggle: false)
    }
    
    @IBAction func btnAddLanguageBycus(_ sender: Any) {
        if self.txtfLanguage.text != ""{
            self.webServicesToAddLanguageByCustomer()
        }else{
            self.showAnnouncement(withMessage: "Please enter language")
        }
    }
    
   
    @IBAction func btnSave(_ sender: UIButton) {
        let valid = validation()
        if valid.success{
            let para = getAllParameterToUpdateProfile()
            self.webServiceCalToUpdateProfile(image: self.imgProfile.image!, para: para)
        } else {
            GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
//MARK:- Custom function here
extension EditProfileVC{
    func initialConfig(){
        DispatchQueue.main.async {
            self.viewTopBG.roundedTop(width: 16, height: 16)
        }
       webServicesToGetProfileData()
        hideAndShow(toggle: true)
    }
    
    func webServicesToGetProfileData() {
        UserDataModel.webServicesToGetCustomerData(params: [:]) { (response) in
            if response != nil{
                self.setData(objCustomerData: response?.objCustomerData)
            }
        }
    }
    
    
    func setData( objCustomerData:CustomerDataModel?){
        if objCustomerData != nil{
            imgProfile.sd_setImage(with: URL(string:objCustomerData?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            self.txtfFullName.text = objCustomerData?.name ?? ""
            self.txtfDateOfBirth.text = objCustomerData?.dob ?? ""
            self.txtfAllergies.text = objCustomerData?.allergies ?? ""
            self.lblLangauge.text = objCustomerData?.language_know ?? ""
            self.txtfServiceDuration.text = objCustomerData?.haircut_freuency ?? ""
        }
    }
    func toSelectImageFromGallery() {
        let camera = Camera(delegate_: self)
         GlobalObj.displayAlertWithHandlerwithSheetStyle(with: "Update your profile/ Cover Picture", message: nil, buttons: ["Camera","Gallery","Cancel"], viewobj: self, buttonStyles: [.default,.default,.cancel], handler: { (selecteutton) in
          if selecteutton == "Camera"{
               camera.PresentMultyCamera(target: self, canEdit: true)
          }else if selecteutton == "Gallery"{
            camera.PresentPhotoLibrary(target: self, canEdit: true)
          }
      })
      }
    func validation() -> (success:Bool, msg:String){
         var bool = true
         var msg = ""
         if txtfFullName.isEmpty(){
             bool = false
             msg = "Please enter full name"
         } else if txtfDateOfBirth.isEmpty(){
             bool = false
             msg = "Please enter your date of birth"
         }else if txtfAllergies.isEmpty(){
            bool = false
            msg = "Please enter Allergies and important information"
         }else if txtfServiceDuration.isEmpty(){
            bool = false
            msg = "Please enter How often do you cut your hair"
        }
         return (success: bool, msg: msg)
     }
}

//MARK:- ImagePicker Stuf here
extension EditProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        //MARK: UIImagePickerController delegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // let video = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
            let picture = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            print(picture as Any,"picture")
            self.imgProfile.image = picture
            // let imagedata = picture?.jpegData(compressionQuality: 0.4)
            picker.dismiss(animated: true, completion: nil)
        }
    }


//MARK:- Webservice calling here -
extension EditProfileVC{
    
    func webServicesToAddLanguageByCustomer(){
        let para = [ParametersKey.language.rawValue:self.txtfLanguage.text!]
        UserDataModel.webServicesToAddLanguage(params:para) { (response) in
            if response != nil{
                self.txtfLanguage.text = ""
                self.webServicesToGetProfileData()
                self.hideAndShow(toggle: true)
            }
        }
    }
    
    func webServiceCalToUpdateProfile(image:UIImage,para:[String:Any]) {
        UserDataModel.WebserviceCallingtoUploadProfilePic(imagePara: image, imageName: ParametersKey.image.rawValue, params: para) { (response) in
            if response != nil{
                self.webServicesToGetProfileData()
            }
            
        }
    }

    func getAllParameterToUpdateProfile()->[String:Any]{
        var para = [String:Any]()
        para[ParametersKey.full_name.rawValue] = self.txtfFullName.text!
        para[ParametersKey.dob.rawValue] = self.txtfDateOfBirth.text!
        para[ParametersKey.allergies_important.rawValue] = self.txtfAllergies.text!
        para[ParametersKey.cut_hair_session.rawValue] = self.txtfServiceDuration.text!
        return para
     }
    
}
