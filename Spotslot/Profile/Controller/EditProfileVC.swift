//
//  EditProfileVC.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

enum HairCutTimePeriod: String, CaseIterable {
    case oneWeek = "1 week"
    case twoWeeks = "2 week"
    case threeWeeks = "3 weeks"
    case oneMonth = "1 month"
    case sixWeeks = "6 weeks"
    case twoMonths = "2 months"
}

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
    var datePicker = UIDatePicker()
    private var pickerView = UIPickerView()
    private var venderLanguages: [LanguageModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        createDatePicker()
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
        let vc = UIStoryboard(name: "Language", bundle: nil).instantiateViewController(withIdentifier: "LanguageListViewController") as! LanguageListViewController
        vc.profileSelectedLanguages = venderLanguages
        vc.languageAddCompletion = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.webServicesToGetProfileData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAddLanguageBycus(_ sender: Any) {

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
        txtfDateOfBirth.inputAccessoryView = toolBar
        txtfDateOfBirth.inputView = datePicker
    }
     
    @objc func donetoShowDate()  {
        let dateformater = DateFormatter()
        dateformater.dateFormat = dateOfBirthFormate
        let str = dateformater.string(from: datePicker.date)
        txtfDateOfBirth.text = str
        self.view.endEditing(true)
    }
    
    @objc func doneForPicker() {
        self.view.endEditing(true)
    }
    
}

extension EditProfileVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        HairCutTimePeriod.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        HairCutTimePeriod.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtfServiceDuration.text = HairCutTimePeriod.allCases[row].rawValue
    }
}

extension EditProfileVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtfServiceDuration {
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.reloadAllComponents()
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.isUserInteractionEnabled = true
            let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.pickerView.setValue(textColor, forKey: "textColor")
            
            toolBar.sizeToFit()
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(doneForPicker))
            doneBarButton.tintColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)

            toolBar.setItems([doneBarButton], animated: false)
            
            txtfServiceDuration.inputAccessoryView = toolBar
            txtfServiceDuration.inputView = pickerView
            
            pickerView.selectRow(0, inComponent: 0, animated: true)
        }
    }
}

//MARK:- Custom function here
extension EditProfileVC{
    func initialConfig(){
        txtfServiceDuration.delegate = self
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
            self.txtfServiceDuration.text = objCustomerData?.haircut_freuency ?? ""
            
            self.venderLanguages = objCustomerData?.language_know ?? []
            let selectedLanguagesNames = objCustomerData?.language_know?.reduce([String](), { (result, language) -> [String] in
                var _result = result
                if language.languageName != nil {
                    _result.append(language.languageName ?? "")
                }
                return _result
            }).joined(separator: ", ")
            self.lblLangauge.text = selectedLanguagesNames
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
    
    func webServiceCalToUpdateProfile(image:UIImage,para:[String:Any]) {
        UserDataModel.WebserviceCallingtoUploadProfilePic(imagePara: image, imageName: ParametersKey.image.rawValue, params: para) { (response) in
            if response != nil{
                GlobalObj.displayAlertWithHandler(with: appName, message: "Profile Updated Successfully", buttons: ["Ok"], viewobj: self) { [weak self] (_) in
                    self?.navigationController?.popViewController(animated: true)
                }
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
