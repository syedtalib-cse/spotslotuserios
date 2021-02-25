//
//  FilterVC.swift
//  Spotslot
//
//  Created by mac on 21/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

protocol DataPass {
    func dataPass(arrOfVendorList: [VendorlistModel])
}




class FilterVC: UIViewController {
    
    @IBOutlet weak var clvFilter: UICollectionView!
    
    //for the gender
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    
    //for the ratting
    @IBOutlet weak var viewAbove4: UIView!
    @IBOutlet weak var view3Star: UIView!
    @IBOutlet weak var lblThree: UILabel!
    @IBOutlet weak var lblAbove4: UILabel!
    
    //for the star
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    
    //MARK:- Class Variable here -
    let TabCol =  ColumnFlowLayoutwitFixWidth(cellsPerRow: 1, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 45, cus_width: 120)
    var arrTab = [String]()
    let radioController: RadioButtonController = RadioButtonController()
    var arrofSpecilization:[SpecializationModel] = []
    var tier = 0
    let selectedColor =  #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
    
    var filterDic = [String:Any]()
    
    var delegate:DataPass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
    }
    
    
    @IBAction func btnApply(_ sender: Any) {
        self.webServicesToGetAllFilteredData()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //for the tier selection
    @IBAction func btnActionX1(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
       // filterDic[ParametersKey.rating.rawValue] = 1
    }
    
    @IBAction func btnActionX2(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
       // filterDic[ParametersKey.rating.rawValue] = 2
    }
    
    @IBAction func btnActionX3(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
       // filterDic[ParametersKey.rating.rawValue] = 3
    }
    
    @IBAction func btnActionX4(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
      // filterDic[ParametersKey.rating.rawValue] = 4
    }
    
    @IBAction func btnActionX5(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
    //    filterDic[ParametersKey.rating.rawValue] = 4
    }
    
    
    //for the Ratting
    @IBAction func btnAbove4Star(_ sender: Any) {
        setbgColorOfrattingButtons()
        self.viewAbove4.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1803921569, blue: 0.2156862745, alpha: 1)
        lblThree.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        filterDic[ParametersKey.rating.rawValue] = 4
    }
    
    @IBAction func btn3Star(_ sender: Any) {
        setbgColorOfrattingButtons()
        self.view3Star.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1803921569, blue: 0.2156862745, alpha: 1)
        lblAbove4.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        filterDic[ParametersKey.rating.rawValue] = 3
    }
    
    func setbgColorOfrattingButtons()  {
        self.view3Star.backgroundColor = UIColor.white
        self.viewAbove4.backgroundColor = UIColor.white
        self.lblThree.textColor = UIColor.white
        self.lblAbove4.textColor = UIColor.white
    }

    
    //for the gender
    @IBAction func btnMale(_ sender: Any) {
        setbgColorOfGender()
        btnFemale.setTitleColor(selectedColor, for: .normal)
        btnMale.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.2235294118, blue: 0.2588235294, alpha: 1)
        filterDic[ParametersKey.gender.rawValue] = Gender.male.rawValue
    }

    @IBAction func btnfemale(_ sender: Any) {
        setbgColorOfGender()
        btnMale.setTitleColor(selectedColor, for: .normal)
        btnFemale.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.2235294118, blue: 0.2588235294, alpha: 1)
        filterDic[ParametersKey.gender.rawValue] = Gender.female.rawValue
    }
    
    @IBAction func cRBChecked(_ sender: UISwitch) {
        if sender.isOn{
            print("status of the switch ")
        }else{
            print("status of the switch \(sender.isOn)")
        }
    }
    
    func setbgColorOfGender()  {
        btnMale.backgroundColor = .white
        btnFemale.backgroundColor = .white
        btnFemale.setTitleColor(.white, for: .normal)
        btnMale.setTitleColor(.white, for: .normal)
    }
    
}
//MARK:- Custom function here
extension FilterVC{
    func intialConfig(){
       self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.arrTab = ["Barber","Hairdresser","Braider","Loctitian"]
        self.clvFilter.collectionViewLayout = self.TabCol
        radioController.buttonsArray = [btn1,btn2,btn3,btn4,btn5]
     //   radioController.defaultButton = btn1
        webServicesCallingToGetSpecializationList()
    }
}

//MARK:- CollectionView Delegate and DataSource
extension FilterVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrofSpecilization.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clvFilter.dequeueReusableCell(withReuseIdentifier: "TabCoolectionCell", for: indexPath) as! TabCoolectionCell
        cell.objFilter = self.arrofSpecilization[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.arrofSpecilization[indexPath.row].isSelected?.toggle()
        self.clvFilter.reloadData()
        if  self.arrofSpecilization[indexPath.row].isSelected!{
            self.filterDic[ParametersKey.specialization_id.rawValue] =  self.arrofSpecilization[indexPath.row].id ?? ""
        }
    }
}


class RadioButtonController: NSObject {
    var buttonsArray: [UIButton]! {
        didSet {
            for b in buttonsArray {
                if b.isSelected == true {
                   b.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    b.titleLabel?.textColor = UIColor.white
                }
            }
        }
    }
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }

    func buttonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
                b.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1803921569, blue: 0.2156862745, alpha: 1)
                b.titleLabel?.textColor = UIColor.white
            } else {
                b.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                b.titleLabel?.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
                b.isSelected = false
            }
        }
    }
}

//MARK:- Webservice calling here -
extension FilterVC{
    func webServicesCallingToGetSpecializationList(){
        UserDataModel.webServicesTogetVendorSpecialization(params: [:]) { (responseModel) in
            if responseModel != nil{
                self.arrofSpecilization = responseModel?.arrofSpecilization ?? []
                self.clvFilter.reloadData()
            }
        }
    }
    
    func webServicesToGetAllFilteredData()  {
        UserDataModel.webServicesToFilter(params: self.filterDic) { (response) in
            if response != nil{
                self.delegate.dataPass(arrOfVendorList: (response?.VendorlistObject) ?? [])
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

