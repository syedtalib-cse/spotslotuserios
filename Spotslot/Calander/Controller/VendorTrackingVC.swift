//
//  VendorTrackingVC.swift
//  Spotslot
//
//  Created by mac on 28/11/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import GoogleMaps

class VendorTrackingVC: UIViewController {
    
    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var viewBookingDetails: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var vendorSpecilization: UILabel!
    @IBOutlet weak var lblPrimarySlot: UILabel!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var viewMap: GMSMapView!
    var objAppointment:Upcomming?
    private let LocationManager = CLLocationManager()
    var longitude = ""
    var latitude = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        setData()
        forMaps()
    }
    
    @IBAction func btnGoToChat(_ sender: Any) {
        let vc = UIStoryboard(name: "Calander", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.objAppointment = self.objAppointment
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnCancelOrder(_ sender: Any) {
        if objAppointment != nil{
            self.showAnnouncementYesOrNo(withMessage: "Do you want to cancel this order?") {
                self.toCancelTheAppointments()
            }
        }
    }

    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Custom function here
extension VendorTrackingVC{
    func initialConfig() {
        DispatchQueue.main.async {
            self.viewBookingDetails.roundedTop(width: 16, height: 16)
        }
        let topColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.09411764706, green: 0.7254901961, blue: 0.7803921569, alpha: 1)
        viewChat.setGradientBackground(colorTop: topColor, colorBottom: bottomColor, radius: 10)
        viewChat.layer.cornerRadius = 16
    }
    
    func setData(){
        if objAppointment != nil{
            imgUser.layer.cornerRadius = imgUser.frame.height/2
            imgUser.sd_setImage(with: URL(string: objAppointment?.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            lblVendorName.text = objAppointment?.vendor_name ?? ""
            vendorSpecilization.text = objAppointment?.username ?? ""
            lblPrimarySlot.text = objAppointment?.primary_slot ?? ""
        }
    }
    
    func forMaps(){
          //for location
          self.LocationManager.requestAlwaysAuthorization()
          self.LocationManager.requestWhenInUseAuthorization()
          LocationManager.desiredAccuracy = kCLLocationAccuracyBest
          LocationManager.distanceFilter = 50
          LocationManager.delegate = self
          viewMap.delegate = self
      }
      
    
}


/*
 status:3
 booking_id:3
 
 */
//MARK:- Webservice calling here -
extension VendorTrackingVC:CLLocationManagerDelegate,GMSMapViewDelegate{
    func toCancelTheAppointments() {
        let para = [ParametersKey.status.rawValue:"3",ParametersKey.booking_id.rawValue:objAppointment?.id ?? ""]
        UserDataModel.webServiceToCancelAPpoint(params: para) { (respons) in
            if respons != nil{
                if respons?.status == 200{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
// MARK: - CLLocationManagerDelegate
extension VendorTrackingVC {
    //Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            LocationManager.startUpdatingLocation()
            viewMap.isMyLocationEnabled = true
            viewMap.settings.myLocationButton = true
        @unknown default:
            fatalError()
        }
    }
    func setMarkeronLocation(_ coordinate:CLLocationCoordinate2D,title:String,snippet:String){
        // // Creates a marker in the center of the map.
        viewMap.clear()
        let position = CLLocationCoordinate2D(latitude:coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.9832366109, green: 0.7234969139, blue: 0.2646969259, alpha: 1))
        marker.tracksViewChanges = true
        marker.isDraggable = true
        marker.title = title
        marker.snippet = snippet
        marker.map = viewMap
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.longitude = "\(coordinate.longitude)"
            self.latitude = "\(coordinate.latitude )"
            let subLocal = address.subLocality ?? ""
            let local = address.locality ?? ""
            self.setMarkeronLocation(coordinate, title: subLocal + " " + local,snippet: lines.joined(separator: "\n"))
        }
    }
}

//Get device Location
extension VendorTrackingVC {
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         print("locations = \(locations)")
        LocationManager.stopUpdatingLocation()
        let cord = LocationManager.location?.coordinate
        viewMap.camera = GMSCameraPosition(target: cord!, zoom: 15, bearing: 15, viewingAngle: 45)
        LocationManager.stopUpdatingLocation()
    }
}
//MARK: - GMSMapViewDelegate
extension VendorTrackingVC {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("coordinate are \(coordinate)")
        reverseGeocodeCoordinate(coordinate)
    }
}
