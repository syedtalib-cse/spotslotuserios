//
//  ChangePaymentVC.swift
//  Spotslot
//
//  Created by Sunil Kumar on 27/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class ChangePaymentVC: UIViewController {
    
    @IBOutlet weak var clvCardList: UICollectionView!
    @IBOutlet weak var imgApplePay: UIImageView!
    @IBOutlet weak var imgGooglePay: UIImageView!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    
    
    @IBOutlet weak var viewApplePay: UIView!
    @IBOutlet weak var viewGooglePay: UIView!
    
    
    let cardConfig = ColumnFlowLayout(cellsPerRow: 1, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 180)
    
    var arrOfPayment:[PaymentMethodList] = []
    var mainArrOfPayment:[PaymentMethodList] = []
    var payment_method_id = ""
    
    var isSelected:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        cardConfig.scrollDirection = .horizontal
        clvCardList.collectionViewLayout = cardConfig
        configureClv()
        togetAllPaymentList()
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddNewPayment(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "AddPaymentVC") as! AddPaymentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnApplePay(_ sender: UIButton){
         self.isSelected = -1
         self.clvCardList.reloadData()
        if !sender.isSelected{
            imgGooglePay.image = UIImage(named: "radio-button")
            imgApplePay.image = UIImage(named: "payment_checked")
            viewApplePay.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
            viewGooglePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
            for  obj in self.mainArrOfPayment{
                if obj.payment_type! == "2"{
                    payment_method_id = obj.id ?? ""
                }
            }
            sender.isSelected = true
        }else{//1=Credit Card/Debit Card, 2=Apple pay,3=Google Pay
            imgApplePay.image = UIImage(named:"radio-button")
            viewApplePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
            sender.isSelected = false
            btnGoogle.isSelected = false
            payment_method_id = ""
        }
    }
    
    
    @IBAction func btnGooglePay(_ sender: UIButton) {
        
        
        
         self.isSelected = -1
         self.clvCardList.reloadData()
        if !sender.isSelected{
            imgApplePay.image = UIImage(named: "radio-button")
            imgGooglePay.image = UIImage(named: "payment_checked")
            sender.isSelected = true
            for  obj in self.mainArrOfPayment{
                if obj.payment_type! == "3"{
                    payment_method_id = obj.id ?? ""
                }
            }
            viewApplePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
            viewGooglePay.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
        }else{
            imgGooglePay.image = UIImage(named: "radio-button")
             viewGooglePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
            sender.isSelected = false
            btnApple.isSelected = false
            payment_method_id = ""
        }
    }
    
    @IBAction func btnChangeMethod(_ sender: Any){
        if self.payment_method_id != ""{
            self.webServiceToMakeDefault()
        }else{
            self.showAnnouncement(withMessage: "Please select your payment method")
        }
    }
}

//MARK:-ollectionView Delegate and DataSource
extension ChangePaymentVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrOfPayment.count
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = clvCardList.dequeueReusableCell(withReuseIdentifier: "CardListCell", for: indexPath) as! CardListCell
        cell.objCard = self.arrOfPayment[indexPath.row]
        if self.isSelected != nil{
            if isSelected == indexPath.row{
                cell.bgCOlorWithFontColor(bgColor: cell.bgActiveColor, fontColor: .white)
                cell.imgClicked.image = UIImage(named:"selected-radio-button")
            }else{
                cell.bgCOlorWithFontColor(bgColor: .white, fontColor: cell.FontActiveColor)
                cell.imgClicked.image = UIImage(named:"radio-button")
            }
        }else{
            //cell.bgCOlorWithFontColor(bgColor: .white, fontColor: cell.FontActiveColor)
           // cell.imgClicked.image = UIImage(named:"radio-button")
        }
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.payment_method_id =  self.arrOfPayment[indexPath.row].id ?? ""
        resetImages()
        self.isSelected = indexPath.row
        self.clvCardList.reloadData()
    }
    func resetImages()  {
       imgApplePay.image = UIImage(named: "radio-button")
       imgGooglePay.image = UIImage(named: "radio-button")
        viewApplePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
        viewGooglePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
    }
}


extension ChangePaymentVC{
    
    func togetAllPaymentList() {
        UserDataModel.webServiceToGetAllPaymentList(params: [:]) { (response) in
            if response != nil{
                self.arrOfPayment = []
                self.mainArrOfPayment = response?.objPaymentMethodList ?? []
                for obj in self.mainArrOfPayment{
                    if obj.payment_type == "1"{
                        self.arrOfPayment.append(obj)
                    }
                }
                self.setOtherPaymentToDetault()
                self.clvCardList.reloadData()
            }
        }
        
    }
    
    func webServiceToMakeDefault()  {
        let para = [ParametersKey.payment_method_id.rawValue:self.payment_method_id]
        UserDataModel.webServiceToMakeDefaultPayment(params: para) { (response) in
            if response != nil{
                self.showAnnouncement(withMessage: response?.message ?? "") {
                    GlobalObj.setRootToDashboard()
                }
            }
        }
        
    }
    
    func configureClv()  {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let cellSize = CGSize(width:screenWidth-50, height:180)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        clvCardList.setCollectionViewLayout(layout, animated: true)
    }
    
    func setOtherPaymentToDetault()  {
        for obj in self.mainArrOfPayment{
            if obj.payment_type! == "2"{
                if obj.isActive! == "1"{
                    imgGooglePay.image = UIImage(named: "radio-button")
                    imgApplePay.image = UIImage(named: "payment_checked")
                    viewGooglePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
                    viewApplePay.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                }
            }else if obj.payment_type! == "3"{
                if obj.isActive! == "1"{
                    imgGooglePay.image = UIImage(named: "payment_checked")
                    imgApplePay.image = UIImage(named: "radio-button")
                    viewGooglePay.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
                    viewApplePay.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
                }
            }
        }
    }
}
