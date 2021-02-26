//
//  ReviewApointmentVC.swift
//  Spotslot
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import FSCalendar
import CoreLocation

class ReviewApointmentVC: UIViewController {

    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var clvSlotlist: UICollectionView!
    @IBOutlet weak var calanderCollectionView: UICollectionView! {
        didSet {
            
            let nib = UINib(nibName: "MonthCalandarCell", bundle: nil)
            calanderCollectionView.register(nib, forCellWithReuseIdentifier: "MonthCalandarCell")
            calanderCollectionView.dataSource = self
            calanderCollectionView.delegate = self
        }
    }
    @IBOutlet weak var heightOfClv: NSLayoutConstraint!
    @IBOutlet weak var fsCalandar: FSCalendar!
    @IBOutlet weak var lblLocations: UILabel!
    @IBOutlet weak var lblSlotSelection: UILabel!
    
    let sloConfig = ColumnFlowLayout(cellsPerRow: 4, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 50)
    private let calendarFlowlayout = ColumnFlowLayoutwitFixWidth(cellsPerRow: 1, height: 100, cus_width: 70)
    var locationManager = CLLocationManager()
    
    var selecteIndex :Int = -1
    let topColor = #colorLiteral(red: 0.09411764706, green: 0.7254901961, blue: 0.7803921569, alpha: 1)
    let bottomColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
    var arrOfTimeSlot:[TimeSlotModel] = []
    
    var primeSlot = ""
    var SecondarySlot = ""
    
    var isSelectedPrimary = false
    var isSelectedSecondary = false
    
    var primarySlotId = ""
    var secondarySlotId = ""

    var primarySlotIndex = -1
    var secondarySlotIndex = -1
    
    var dataDic = [String:Any]()
    var selectedDate: Date?
    var vendorId = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var address = ""
    
    private var dates = [Date]()
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
        //fsCalandar.scope = .week
        //fsCalandar.delegate = self
       
        locationConfigure()
        getDates()
       
    }
    
    private func getDates() {
        
        self.calendarFlowlayout.scrollDirection = .horizontal
        self.calanderCollectionView.collectionViewLayout = self.calendarFlowlayout
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none

        var twoMonthAgoComponent = DateComponents()
        twoMonthAgoComponent.month = 2

        var date = Date()
        let calendar = Calendar.current
        let lastDate = calendar.date(byAdding: twoMonthAgoComponent, to: date, wrappingComponents: false)

        var dayAgoComponent = DateComponents()
        dayAgoComponent.day = 1

        while (date != lastDate) {
            if let _date = calendar.date(byAdding: dayAgoComponent, to: date, wrappingComponents: false) {
                //dateByAddingComponents(dayAgoComponent, toDate: date, options: NSCalendar.Options.MatchFirst)!
                date = _date
                //dates.append(dateFormatter.string(from: date))
                dates.append(date.removeTimeStamp())
            }
        }

        print(dates)
        
        DispatchQueue.main.async {
            self.calanderCollectionView.reloadData()
            if let index =  self.dates.firstIndex(of: self.selectedDate ?? Date()) {
                let indexPath = IndexPath(item: index, section: 0)
                self.calanderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pushToMap(_ sender: Any) {
        /*let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SetViewController") as! SetViewController
        self.navigationController?.pushViewController(vc, animated: true)*/
        
        let vc = UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: "AddressPickerViewController") as! AddressPickerViewController
        vc.getLocationAndAddressCompletion = { [weak self] (latitude, longitude, address) in
            guard let self = self else {return}
            self.navigationController?.popViewController(animated: true)
            self.latitude = Double(latitude) ?? 0
            self.longitude = Double(longitude) ?? 0
            self.address = address
            self.lblLocations.text = self.address
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPushToSumarry(_ sender: Any) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "BookingSummaryVC") as! BookingSummaryVC
        vc.dataDic = self.dataDic
        if latitude != 0 && longitude != 0, let addressText = self.lblLocations.text, !addressText.isEmpty {
            vc.latitude = latitude
            vc.longitude = longitude
            vc.address = addressText
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            self.showAnnouncement(withMessage: "Please Select Location for booking.")
        }
    }
    
}

//MARK:- Custom Function
extension ReviewApointmentVC{
    func intialConfig(){
        DispatchQueue.main.async {
            self.viewBg.roundedTop(width: 16, height: 16)
            
        }
        clvSlotlist.collectionViewLayout = self.sloConfig
        webServicesToGetTimeSlot()
    }
    
    func locationConfigure(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

//Collectionview Delegate and DataSource
extension ReviewApointmentVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == calanderCollectionView {
            return dates.count
        }else {
            DispatchQueue.main.async {
                self.heightOfClv.constant = self.clvSlotlist.contentSize.height
            }
            return  self.arrOfTimeSlot.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == calanderCollectionView {
            let cell = calanderCollectionView.dequeueReusableCell(withReuseIdentifier: "MonthCalandarCell", for: indexPath)  as! MonthCalandarCell
            cell.configure(date: dates[indexPath.item], selectedDate: selectedDate ?? Date())
            return cell
        }else {
            
            let cell = clvSlotlist.dequeueReusableCell(withReuseIdentifier: "slotCell", for: indexPath)  as! slotCell
            cell.lblTimeOfSlot.text = self.arrOfTimeSlot[indexPath.row].hours_format ?? ""
            DispatchQueue.main.async {
                if self.primarySlotIndex == indexPath.row{
                    cell.viewBg.backgroundColor = #colorLiteral(red: 0.004608990159, green: 0.7726951241, blue: 0.8249664903, alpha: 1)
                    cell.lblTimeOfSlot.textColor = UIColor.white
                    //  self.
                }else if self.secondarySlotIndex == indexPath.row  {
                    cell.viewBg.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2235294118, blue: 0.2470588235, alpha: 1)
                    cell.lblTimeOfSlot.textColor = UIColor.white
                } else{
                    cell.viewBg.backgroundColor = UIColor.white
                    cell.lblTimeOfSlot.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
                }
            }
            
            
            if self.arrOfTimeSlot[indexPath.row].today_status! == GenralText.available.rawValue{
                cell.viewBg.backgroundColor = UIColor.white
                cell.lblTimeOfSlot.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
                cell.lblRequestedCell.isHidden = true
            }else if self.arrOfTimeSlot[indexPath.row].today_status == GenralText.confirm.rawValue{
                cell.viewBg.backgroundColor = UIColor.white
                cell.lblTimeOfSlot.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 0.8)
                cell.lblRequestedCell.isHidden = true
            }else if self.arrOfTimeSlot[indexPath.row].today_status == GenralText.request.rawValue{
                cell.lblRequestedCell.isHidden = false
                cell.lblRequestedCell.cornerRadius = cell.lblRequestedCell.frame.height/2
            }
            
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView == calanderCollectionView {
            if let index = dates.firstIndex(of: selectedDate ?? Date()) {
                let oldIndexPath = IndexPath(item: index, section: 0)
                selectedDate = dates[indexPath.item]
                self.calanderCollectionView.reloadItems(at: [oldIndexPath, indexPath])
                dataDic["appointmentDate"] = (selectedDate ?? Date()).getStringDate()
            }
        }else {
            if !isSelectedPrimary{
                self.primeSlot = self.arrOfTimeSlot[indexPath.row].hours_format ?? ""
                self.primarySlotId = self.arrOfTimeSlot[indexPath.row].id ?? ""
                self.primarySlotIndex = indexPath.row
                isSelectedPrimary = true
            }else{
                
                let secondarySlot = GlobalObj.strToDate(strDate: self.arrOfTimeSlot[indexPath.row].hours_format ?? "")
                let primarySlot = GlobalObj.strToDate(strDate:self.primeSlot)
                if primarySlot > secondarySlot{
                    
                    //for index
                    let temPrimaryIndex = self.primarySlotIndex
                    self.primarySlotIndex = indexPath.row
                    self.secondarySlotIndex = temPrimaryIndex
                    
                    //for ids
                    let temPrimaryId = self.primarySlotId
                    self.primarySlotId = self.arrOfTimeSlot[indexPath.row].id ?? ""
                    self.secondarySlotId = temPrimaryId
                    
                    //for time
                    let tempPrimarySlot = self.primeSlot
                    self.primeSlot = self.arrOfTimeSlot[indexPath.row].hours_format ?? ""
                    self.SecondarySlot = tempPrimarySlot
                    
                }else{
                    self.secondarySlotId = self.arrOfTimeSlot[indexPath.row].id ?? ""
                    self.SecondarySlot = self.arrOfTimeSlot[indexPath.row].hours_format ?? ""
                    self.secondarySlotIndex = indexPath.row
                }
            }
            
            if  self.primeSlot != ""{
                lblSlotSelection.text = "Select 1 secondary slot"
            }
            
            if self.primeSlot != "" && self.SecondarySlot != ""{
                lblSlotSelection.text = "All slot selected"
            }
            
            //to forward this to the next screen
            dataDic["primaryslot"] = self.primarySlotId
            dataDic["secondarySlot"] = self.secondarySlotId
            dataDic["primaryslotTime"] = self.primeSlot
            dataDic["secondarySlotTime"] = self.SecondarySlot
            self.selecteIndex = indexPath.row
            self.clvSlotlist.reloadData()
        }
    }
}

/*//FSCalandar
extension ReviewApointmentVC: FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance{

   // For autoLayout
//    func calendar(_ calendar: FSCalendar?, boundingRectWillChange bounds: CGRect) {
//      //  calendarHeightConstraint.constant = bounds.height
//        view.layoutIfNeeded()
//    }

    // For manual layout
    func calendar(_ calendar: FSCalendar?, boundingRectWillChange bounds: CGRect) {
        calendar?.frame = CGRect(origin: (calendar?.frame.origin)!, size: bounds.size)
    }
}
*/
//Get device Location
extension ReviewApointmentVC: CLLocationManagerDelegate {
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        locationManager.stopUpdatingLocation()
        if let cord = locationManager.location?.coordinate {
            self.latitude = cord.latitude
            self.longitude = cord.longitude
            getAddressFromCoordinate(cord)
        }
    }
    
    //      Mark :-  Reverse geodcode
    func getAddressFromCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let loc: CLLocation = CLLocation(latitude:coordinate.latitude, longitude: coordinate.longitude)
        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                 let pm = placemarks! as [CLPlacemark]
                 if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    self.lblLocations.text = addressString
                }
        })
    }
}

//MARK:- Webservice calling here -
extension ReviewApointmentVC{
    func webServicesToGetTimeSlot(){
        UserDataModel.webServicesTogetTimeSlotData(params: [ParametersKey.vendor_id.rawValue:self.vendorId]) { (response) in
            if response != nil{
                self.arrOfTimeSlot = response?.arrOfTimeSlot ?? []
                self.clvSlotlist.reloadData()
            }
        }
    }
}
