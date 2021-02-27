//
//  BookingSummaryVC.swift
//  Spotslot
//
//  Created by Sunil Kumar on 26/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import  CoreLocation
import Stripe

class BookingSummaryVC: UIViewController {

    @IBOutlet weak var viewBG: UIView!
    
    @IBOutlet weak var imgVendor: UIImageView!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var lblVendorUserName: UILabel!
    @IBOutlet weak var lblSpotAddress: UILabel!
    @IBOutlet weak var lblVendorAppointmentDate: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblServiceFee: UILabel!
    @IBOutlet weak var lblTravelFee: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var personServiceFeeLabel: UILabel!
    
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPrimarySlot: UILabel!
    @IBOutlet weak var lblSecondrySlot: UILabel!
    
    var latitude = 0.0
    var longitude = 0.0
    var address = ""
    var mainAddress: CoverageDetail!
    var dataDic = [String:Any]()
    private var finalServicePrice: Double = 0
    private var travelFee: Double = 0
    private var finalTotalFee: Double {
        get {
            return finalServicePrice + travelFee
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
        setData()
    }

    @IBAction func btnBack(_ sender: Any) {
     self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPushTOChnagePaymenyt(_ sender: Any) {
    let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ChangePaymentVC") as! ChangePaymentVC
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBook(_ sender: Any) {
        
        createStripeToken()
     
    }
}

//MARK:- Custom Function
extension BookingSummaryVC{
    
    func pushToSuccess()  {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AppointmentRequestedVC") as! AppointmentRequestedVC
        vc.vendorName = self.lblVendorName.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func intialConfig(){
       DispatchQueue.main.async {
          self.viewBG.roundedTop(width: 16, height: 16)
        }
    }
    
    func setData(){
        lblTravelFee.text = "\(GenralText.currency.rawValue) \(0)"
        if let objAbout = dataDic["about"] as? About{
            imgVendor.sd_setImage(with: URL(string: objAbout.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            lblVendorName.text = objAbout.name ?? ""
            lblVendorUserName.text = objAbout.user_name ?? ""
        }
        if let primary = dataDic["primaryslotTime"] as? String{
            self.lblPrimarySlot.text = primary
        }
        if let secondry = dataDic["secondarySlotTime"] as? String{
            self.lblSecondrySlot.text = secondry
        }
        
        if let numberOfPersons = dataDic[ParametersKey.no_of_person.rawValue] as? String {
            personServiceFeeLabel.text = "Service Fee (\(numberOfPersons) Person)"
        }else {
            personServiceFeeLabel.text = "Service Fee"
        }
        self.lblSpotAddress.text = address
        
        if let service = dataDic["service"] as? Service_list{
            
            lblServiceName.text = service.group_name ?? service.service_name ?? service.subcription_name ?? service.package_name ?? ""
            
            if service.service_charge != nil, let serViceCharge = service.service_charge{
                finalServicePrice = Double(serViceCharge) ?? 0
            }
            if service.price != nil, let price = service.price{
                finalServicePrice = Double(price) ?? 0
            }
            lblServiceFee.text = "\(GenralText.currency.rawValue) \(finalServicePrice)"
            
            lblTotal.text = "\(GenralText.currency.rawValue) \(finalServicePrice)"
            if let vendorLatitude = mainAddress.latitude, let vendorLongitude = mainAddress.longitude {
                //print(mainAddress.address)
                //print("vendorLAtlong Double:- \(Double(vendorLatitude) ?? 0) || \(Double(vendorLongitude) ?? 0)")
                //print("USerLAtlong Double:- \(latitude) || \(longitude)")
                let userLocation = CLLocation(latitude: latitude, longitude: longitude)
                let vendorMainLocation = CLLocation(latitude: Double(vendorLatitude) ?? 0, longitude: Double(vendorLongitude) ?? 0)
                travelFee = getTravelFeeByDistance(fromLocation: userLocation, toLocation: vendorMainLocation, With: .miles)
                lblTravelFee.text = "\(GenralText.currency.rawValue) \(travelFee)"
                lblTotal.text = "\(GenralText.currency.rawValue) \(finalServicePrice + travelFee)"
            }
        }
        
        if let date = dataDic["appointmentDate"] as? String{
            lblVendorAppointmentDate.text = date
        }
    }
    
}

//MARK: - Distance Calculation for Travel Fee
extension BookingSummaryVC {
    private func getTravelFeeByDistance(fromLocation: CLLocation, toLocation: CLLocation, With type: DistanceMeasurementType)-> Double {
        let distance = getDistanceBetweenTwoLocations(fromLocation: fromLocation, toLocation: toLocation, type: type)
        switch type {
        case .miles:
            return distance * 1.50 // £1.50 per 1 mile,
        }
    }
    
    private func getDistanceBetweenTwoLocations(fromLocation: CLLocation, toLocation: CLLocation, type: DistanceMeasurementType)-> Double {
        let distance = fromLocation.distance(from: toLocation)
        let convertedDistance = self.distanceMeasurement(distance: distance, With: type)
        return convertedDistance
    }
    
    private func distanceMeasurement(distance: CLLocationDistance, With type: DistanceMeasurementType)-> Double {
        switch type {
        case .miles:
            let miles = distance * 0.00062137 // this fromula is came from google
            return round(miles)
        }
    }
    
    enum DistanceMeasurementType {
        case miles
    }
}


//MARK:- Webservice calling here -
extension BookingSummaryVC{
    
    /*
     transaction_id:#42124d5sf5dsf4
     payment_status:success
     payment_id:1
     
     */
    
    func webServiceToBookServices(paymentId:String,transaction_id:String,status:String){
        let para = getAllParameter(paymentId:paymentId,transaction_id:transaction_id,status:status)
        UserDataModel.webServicesToBookServices(params: para) { (response) in
            if response != nil{
                //self.showAnnouncement(withMessage: response?.message ?? "") {
                self.pushToSuccess()
                //  }
            }
        }
    }
    
    
    func webServiceToMakePayment(para:[String:Any])  {
        UserDataModel.weberviceToMakePayment(params: para) { (response) in
            if response != nil{
                if response?.status == 200{
                    self.showAnnouncement(withMessage: "Payement successfully completed click to proceed booking") {
                        self.webServiceToBookServices(paymentId: "\(response?.objPaymentModel?.payment_id ?? 0)", transaction_id: response?.objPaymentModel?.transaction_id ?? "", status: response?.objPaymentModel?.stripe_status ?? "")
                    }
                    //do your code here
                }
            }
        }
    }
    
    func getAllParameter(paymentId:String,transaction_id:String,status:String) ->[String:Any] {
        var para = [String:Any]()
        if let objAbout = dataDic["about"] as? About{
            para[ParametersKey.vendor_id.rawValue] = objAbout.id ?? ""
        }
        if let service = dataDic["service"] as? Service_list{
            para[ParametersKey.service_id.rawValue] = service.id ?? ""
            para[ParametersKey.service_type.rawValue] = service.service_type ?? ""
            para[ParametersKey.total_service_fee.rawValue] = finalTotalFee
            para[ParametersKey.service_fee.rawValue] = finalServicePrice
            
        }
        para[ParametersKey.payment_id.rawValue] = paymentId
        para[ParametersKey.transaction_id.rawValue] = transaction_id
        para[ParametersKey.payment_status.rawValue] = status
        if let date = dataDic["appointmentDate"] as? String{
            para[ParametersKey.appointment_date.rawValue] = date
        }
        if let primary = dataDic["primaryslot"] as? String{
            para[ParametersKey.primary_time_slot_id.rawValue] = primary
            
            if let secondry = dataDic["secondarySlot"] as? String{
                para[ParametersKey.secondary_time_slot_id.rawValue] = secondry
            }
            para[ParametersKey.address.rawValue] = self.lblSpotAddress.text
            para[ParametersKey.duration.rawValue] = "1"
            para[ParametersKey.travel_fee.rawValue] = travelFee
            para[ParametersKey.payment_method.rawValue] = "Google Pay"
            para[ParametersKey.latitude.rawValue] = self.latitude
            para[ParametersKey.longitude.rawValue] = self.longitude
            if let numberOfPerson = dataDic[ParametersKey.no_of_person.rawValue] as? String{
                para[ParametersKey.no_of_person.rawValue] = numberOfPerson
            }
        }
        return para
    }
}


//MARK:- Stripe related things
extension BookingSummaryVC{
    func createStripeToken() {
        dismiss(animated: true, completion: nil)
        let cardParams = STPCardParams()
        cardParams.number = "4242424242424242"
        cardParams.expMonth = UInt("03")!//"03"
        cardParams.expYear = UInt("2023")!//"2023"
        cardParams.cvc = "123"
        cardParams.name = "Nicholas Cumberbatch"
      //  cardParams.address = "Indore"
        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                return
            }
            print("token is \(token.tokenId)")
            let para = [ParametersKey.stripeToken.rawValue:token.tokenId,
                        ParametersKey.payment_card_id.rawValue:"0",
                        ParametersKey.amount.rawValue: self.finalTotalFee] as [String : Any]
            self.webServiceToMakePayment(para: para)
            print(token.tokenId)
        }
    }
}
