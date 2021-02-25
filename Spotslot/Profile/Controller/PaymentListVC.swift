//
//  PaymentListVC.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//
/*
 
 
 */
import UIKit

class PaymentListVC: UIViewController {

    @IBOutlet weak var tlvPaymetList: UITableView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    
    var arrOfPayment:[PaymentMethodList] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.viewTop.roundedTop(width: 16, height: 16)
        }
        if let profile_img  = SharedPreference.getUserData().profile_image{
            self.imgUser.sd_setImage(with: URL(string:profile_img), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        togetAllPaymentList()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        GlobalObj.setRootToDashboard()
    }
    
    @IBAction func btnAddpayment(_ sender: Any) {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "AddPaymentVC") as! AddPaymentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- Delegate and DataSource Methods Of TableView
extension PaymentListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfPayment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.arrOfPayment[indexPath.row].payment_type == "1"{
            tlvPaymetList.register(UINib(nibName: "CardAddedCell", bundle: nil), forCellReuseIdentifier: "CardAddedCell")
            let cell = tlvPaymetList.dequeueReusableCell(withIdentifier: "CardAddedCell", for: indexPath) as! CardAddedCell
            cell.obj = self.arrOfPayment[indexPath.row]
            cell.openToEditAndDelete {
               self.toOpenBottomSheetToeditAndDeleteAddress(index: indexPath)
            }
            cell.selectionStyle = .none
            return cell
        }else{
            tlvPaymetList.register(UINib(nibName: "OtherPayListCell", bundle: nil), forCellReuseIdentifier: "OtherPayListCell")
            let cell = tlvPaymetList.dequeueReusableCell(withIdentifier: "OtherPayListCell", for: indexPath) as! OtherPayListCell
            cell.obj = self.arrOfPayment[indexPath.row]
            cell.openToEditAndDelete {
                self.toOpenBottomSheetToeditAndDeleteAddress(index: indexPath)
            }
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.arrOfPayment[indexPath.row].payment_type == "1"{
            return 125
        }else{
            return 90
        }
    }
}

//MARK:- Webservice calling here -
extension PaymentListVC{
    
    func togetAllPaymentList() {
        UserDataModel.webServiceToGetAllPaymentList(params: [:]) { (response) in
            if response != nil{
                self.arrOfPayment = []
                self.arrOfPayment = response?.objPaymentMethodList ?? []
                self.tlvPaymetList.reloadData()
            }
        }
    }
    
    func toOpenBottomSheetToeditAndDeleteAddress(index:IndexPath) {
         let objToEditDelete = self.arrOfPayment[index.row]
        GlobalObj.displayAlertWithHandlerwithSheetStyle(with: "", message: nil, buttons: ["Edit","Delete","Cancel"], viewobj: self, buttonStyles: [.default,.default,.cancel], handler: { (selecteutton) in
            if selecteutton == "Edit"{
                let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "AddPaymentVC") as! AddPaymentVC
                vc.isForEdit = true
                vc.objToEdit = objToEditDelete
                self.navigationController?.pushViewController(vc, animated: true)
            }else if selecteutton == "Delete"{
                self.showAnnouncementYesOrNo(withMessage: "Do you want to delete?") {
                    self.webServiceToDeletePayment(id: objToEditDelete.id ?? "")
                }
            }
        })
    }
    
    func webServiceToDeletePayment(id:String){
        UserDataModel.webServicesToDeletePaymentMethod(params: [ParametersKey.payment_method_id.rawValue:id]) { (response) in
            if response != nil{
                self.togetAllPaymentList()
            }
        }
    }
    
}
