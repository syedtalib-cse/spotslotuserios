//
//  CalanderVC.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class CalanderVC: UIViewController {
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var clvTab: UICollectionView!
    @IBOutlet weak var viewAppointment: UIView!
    @IBOutlet weak var tlvpointment: UITableView!
    
    @IBOutlet weak var heightOftlv: NSLayoutConstraint!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewApointmentDetails: UIView!
    
    
    @IBOutlet weak var imgVendor: UIImageView!
    @IBOutlet weak var lblSpecialization: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblServiceFeee: UILabel!
    @IBOutlet weak var lblTravelFee: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblCardType: UILabel!
    @IBOutlet weak var lblCardHolderName: UILabel!
    
    
    
    //MARK:- Class Variable here -
    let TabCol =  ColumnFlowLayoutwitFixWidth(cellsPerRow: 1, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 90, cus_width: 250)
    var upcomming : [Upcomming] = []
    var previous : [Previous] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        webServiceToGetAllAppointmnets()
    }
    
    //Mark:- Hide on touch on bg
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            if touch.view! == self.viewBackground{
                hideAbdShow(toggle: true)
            }
        }
    }
}

//MARK:- Custom function here
extension CalanderVC{
    func initialConfig(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        clvTab.collectionViewLayout = self.TabCol
        DispatchQueue.main.async {
            self.viewBG.roundedTop(width: 16, height: 16)
            self.viewAppointment.roundedTop(width: 16, height: 16)
            self.viewApointmentDetails.roundedTop(width: 16, height: 16)
        }
        self.tlvpointment.register(UINib(nibName: "ApintmentCell", bundle: nil), forCellReuseIdentifier: "ApintmentCell")
        hideAbdShow(toggle: true)
      
    }
    func hideAbdShow(toggle:Bool){
        self.viewBackground.isHidden = toggle
        self.viewApointmentDetails.isHidden = toggle
    }
}

//MARK:- CollectionView Delegate and DataSource
extension CalanderVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.upcomming.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.upcomming[indexPath.row].booking_detail?.travel_status == "1"{
            let cell = clvTab.dequeueReusableCell(withReuseIdentifier: "CalanderCellOnTheWay", for: indexPath) as! CalanderCell
            cell.objUpcomming2 = self.upcomming[indexPath.row]
            return cell
            
        }else{
            let cell = clvTab.dequeueReusableCell(withReuseIdentifier: "CalanderCell", for: indexPath) as! CalanderCell
            cell.objUpcomming = self.upcomming[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if self.upcomming[indexPath.row].booking_detail?.travel_status == "1"{
            let vc = UIStoryboard(name: "Calander", bundle: nil).instantiateViewController(withIdentifier: "VendorTrackingVC") as! VendorTrackingVC
            vc.objAppointment = self.upcomming[indexPath.row]
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:- Delegate and DataSource Methods Of TableView
extension CalanderVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previous.count
    }
    
    override func viewWillLayoutSubviews() {
          super.updateViewConstraints()
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tlvpointment.dequeueReusableCell(withIdentifier: "ApintmentCell", for: indexPath) as! ApintmentCell
        cell.objAppointment = self.previous[indexPath.row]
        cell.didTapToRate {
            if self.previous[indexPath.row].isRated! == 0{
            self.pushToRateScreen(preViousObj:self.previous[indexPath.row])
            }else{
          //vendor_id
                let objVende_Id = self.previous[indexPath.row]
                let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "VendorProfileVC") as! VendorProfileVC
                vc.vendor_id  = objVende_Id.vendor_id!
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
       
        }
        cell.selectionStyle = .none
        return cell
   }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setDataToPopUp(objPrevious: self.previous[indexPath.row])
        hideAbdShow(toggle: false)
    }
    
    func setDataToPopUp(objPrevious:Previous)  {
       imgVendor.sd_setImage(with: URL(string: objPrevious.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder."))
        lblSpecialization.text = objPrevious.username ?? ""
        lblUserName.text = objPrevious.vendor_name ?? ""
        
        //lblOrderNumber.text = ""
        
        lblAddress.text = objPrevious.booking_detail?.address ?? ""
        lblDates.text = objPrevious.booking_detail?.appointment_date ?? ""
        lblServiceName.text = objPrevious.booking_detail?.service_detail?.service_name ?? ""
        lblServiceFeee.text = objPrevious.booking_detail?.service_detail?.service_charge ?? ""
        
        //lblTotal.text = objPrevious.booking_detail?.service_detail.u //pending here
        //lblCardNumber
       // lblCardType
        //lblCardHolderName
    }
    
}

//MARK:- Webservice calling here -
extension CalanderVC{
    func webServiceToGetAllAppointmnets(){
        UserDataModel.webServiceToGetAllAppointmentList(params: [:]) { (response) in
            if response != nil{
                self.previous = response?.objCalandarModel?.previous ?? []
                self.upcomming = response?.objCalandarModel?.upcomming ?? []
                self.tlvpointment.reloadData()
                self.clvTab.reloadData()
             }
        }
    }
    
    func pushToRateScreen(preViousObj:Previous)  {
        let vc = UIStoryboard(name: "Calander", bundle: nil).instantiateViewController(withIdentifier: "RateVC") as! RateVC
        vc.objPrevious = preViousObj
//        print("url is \(preViousObj.vendor_image)")
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
