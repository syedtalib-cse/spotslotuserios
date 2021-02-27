//
//  EditAddressVC.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
//import GooglePlacePicker



class EditAddressVC: UIViewController {
    
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var tlvAddressList: UITableView!
    @IBOutlet weak var lblLocationAddress: UITextField!
    @IBOutlet weak var txtfHomeName: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var txtfAddress: UITextField!
    
    var arrOfAddress:[AddressListModel] = []
    
    var longitude = ""
    var latitude = ""
    var address = ""
    var addId = ""
    
  
    
    private let LocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    @IBAction func btnSetLoac(_ sender: Any) {
        self.viewAddress.isHidden = true
        hideMap(toggle: false)
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        self.txtfHomeName.text =  ""
        self.lblLocationAddress.text = ""
        self.hideAndShow(toggle: false)
    }
    
    @IBAction func btnBackToAddressView(_ sender: Any) {
        self.viewBG.isHidden = true
        self.viewMap.isHidden = true
        self.hideAndShow(toggle:false)
    }
    
    @IBAction func btnBack(_ sender: Any) {
     self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.hideAndShow(toggle: true)
    }
    
    @IBAction func btnPickLoc(_ sender: Any) {
        self.viewMap.isHidden = true
        self.viewBG.isHidden = false
        self.viewAddress.isHidden = false
    }
    
    @IBAction func toPickAddressManually(_ sender: UITextField) {
//        let acController = GMSAutocompleteViewController()
//        acController.delegate = self
//        self.present(acController, animated: true, completion: nil)
         let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self as? GMSAutocompleteViewControllerDelegate
        present(autocompleteController, animated: true, completion: nil)

    }
    
    
    
    @IBAction func btnContinue(_ sender: Any) {
        let valid = validation()
        if valid.success{
            webServiceCallingToAddAddress()
        } else {
            GlobalObj.showAlertVC(title:appName, message: valid.msg, controller: self)
        }
    }
    
    func validation() -> (success:Bool, msg:String){
        var bool = true
        var msg = ""
        if txtfHomeName.isEmpty(){
            bool = false
            msg = "Please enter your address name"
        } else if lblLocationAddress.isEmpty(){
            bool = false
            msg = "Please select address"
        }
        return (success: bool, msg: msg)
    }
    
}
//MARK:- Custom function here
extension EditAddressVC{
     func toOpenBottomSheetToeditAndDeleteAddress(index:IndexPath) {
        let obj = self.arrOfAddress[index.row]
        self.addId = obj.user_address_id ?? ""
        GlobalObj.displayAlertWithHandlerwithSheetStyle(with: "", message: nil, buttons: [Messge.messageToMainAdd,Messge.messageToEditAdd,Messge.messageToDeleteAdd,"Cancel"], viewobj: self, buttonStyles: [.default,.default,.default,.cancel], handler: { (selecteutton) in
            if selecteutton == Messge.messageToMainAdd{
                self.webSerVicesToMakeMain()
            }else if selecteutton == Messge.messageToEditAdd{
                self.hideAndShow(toggle: false)
                self.txtfHomeName.text = obj.address_name ?? ""
                self.lblLocationAddress.text = obj.location ?? ""
                self.latitude = obj.user_latitude ?? ""
                self.longitude = obj.user_logitude ?? ""
                let para = self.getAllParameterToEdit(strLat: self.latitude, strLong: self.longitude)
                self.webServicesToEditAddress(para: para)
            }else if selecteutton == Messge.messageToDeleteAdd{
                self.showAnnouncementYesOrNo(withMessage: "Do you want to delete") {
                    self.webServiceToDeleteAddress()
                }
            }
        })
    }
    
    
    func initialConfig(){
        DispatchQueue.main.async {
            self.viewTopBG.roundedTop(width: 16, height: 16)
        }
        self.navigationController?.setNavigationBarHidden(true, animated:true)
        self.tlvAddressList.register(UINib(nibName: "AddresslistCell", bundle: nil), forCellReuseIdentifier: "AddresslistCell")
        hideAndShow(toggle: true)
        mapView.backgroundColor = UIColor.black
        hideMap(toggle: true)
        webSerVicessToGetAddressList()
        
        //for location
        self.LocationManager.requestAlwaysAuthorization()
        self.LocationManager.requestWhenInUseAuthorization()
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.distanceFilter = 50
        LocationManager.delegate = self
        mapView.delegate = self
        
        if let profile_img  = SharedPreference.getUserData().profile_image{
            self.imgUser.sd_setImage(with: URL(string:profile_img), placeholderImage: UIImage(named: "placeholder"))
        }
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "DarkStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
   
    func hideAndShow(toggle:Bool){
        self.viewBG.isHidden = toggle
        self.viewAddress.isHidden = toggle
    }
    
    func hideMap(toggle:Bool){
        self.viewBG.isHidden = toggle
        self.viewMap.isHidden = toggle
     }
    
    func setMarkeronLocation(_ coordinate:CLLocationCoordinate2D,title:String,snippet:String){
       // // Creates a marker in the center of the map.
        mapView.clear()
        let position = CLLocationCoordinate2D(latitude:coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.icon = #imageLiteral(resourceName: "pin")
        marker.tracksViewChanges = true
        marker.isDraggable = true
        marker.title = title
        marker.snippet = snippet
        marker.map = mapView
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.lblLocationAddress.text = lines.joined(separator: "\n")
            print("address is \(lines.joined(separator: "\n"))")
            self.txtfAddress.text = lines.joined(separator: "\n")
//            self.address = address.locality ?? ""
                self.latitude = "\(coordinate.latitude)";
                self.longitude = "\(coordinate.longitude)";
            //self.zipCode = address.postalCode ?? ""
            //self.longitude = "\(coordinate.longitude)"
            //self.latitude = "\(coordinate.latitude )"
            // self.state = address.administrativeArea ?? ""
            //self.country = address.country ?? ""
            let subLocal = address.subLocality ?? ""
            let local = address.locality ?? ""
            self.setMarkeronLocation(coordinate, title: subLocal + " " + local,snippet: lines.joined(separator: "\n"))
          //  self.getAddressFromLatLon(pdblLatitude: "\(String(describing: coordinate.latitude))", withLongitude: "\(String(describing: coordinate.longitude))")
        }
    }
}

//MARK:- Webservice calling here -
extension EditAddressVC{
    func webSerVicessToGetAddressList() {
        UserDataModel.webServicesTogetMyAddress(params: [:]) { (response) in
            if response != nil{
                self.arrOfAddress = response?.arrOfAddressObj ?? []
                self.tlvAddressList.reloadData()
            }
        }
    }
}

//MARK:- Delegate and DataSource Methods Of TableView
extension EditAddressVC:UITableViewDelegate,UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tlvAddressList.dequeueReusableCell(withIdentifier: "AddresslistCell", for: indexPath) as! AddresslistCell
        cell.objAddress = self.arrOfAddress[indexPath.row]
        cell.toOpenBottomSheet {
            self.toOpenBottomSheetToeditAndDeleteAddress(index: indexPath)
        }
        if indexPath.row == 0{
            cell.lblMainAdd.isHidden = false
        }else{
            cell.lblMainAdd.isHidden = true
        }
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: - CLLocationManagerDelegate
extension EditAddressVC {
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
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
      @unknown default:
        fatalError()
      }
    }

}


//Get device Location
extension EditAddressVC: CLLocationManagerDelegate {
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         print("locations = \(locations)")
        LocationManager.stopUpdatingLocation()
        let cord = LocationManager.location?.coordinate
        mapView.camera = GMSCameraPosition(target: cord!, zoom: 15, bearing: 10, viewingAngle: 25)
       // mapView.setMinZoom(0, maxZoom: a)
        LocationManager.stopUpdatingLocation()
    }
    

}


//// MARK: - GMSMapViewDelegate
extension EditAddressVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("coordinate are \(coordinate)")
        reverseGeocodeCoordinate(coordinate)
    }
}


//MARK:- Webservice calling here -
extension EditAddressVC{
    
    func getAllParameter() ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.location.rawValue] = self.lblLocationAddress.text ?? ""
        para["latitude"] = self.latitude
        para["logitude"] = self.longitude
        para[ParametersKey.address_name.rawValue] = self.txtfHomeName.text!
        return para
    }
    
    func getAllParameterToEdit(strLat:String,strLong:String) ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.location.rawValue] = self.lblLocationAddress.text ?? ""
        para["latitude"] = self.latitude
        para["logitude"] = self.longitude
        para[ParametersKey.address_name.rawValue] = self.txtfHomeName.text!
        para[ParametersKey.user_address_id.rawValue] = self.addId
       return para
    }
    
    
    func webServicesToEditAddress(para:[String:Any]){
        UserDataModel.webServiceToEditMyAddress(params: para) { (response) in
            if response != nil{
             self.webSerVicessToGetAddressList()
            }
        }
    }
    func webServiceToDeleteAddress()  {
        let para = [ParametersKey.user_address_id.rawValue:self.addId]
        UserDataModel.webServiceToDeleteMyAddress(params: para) { (response) in
            if response != nil{
              self.webSerVicessToGetAddressList()
            }
        }
    }
    
    func webSerVicesToMakeMain() {
       let para = ["address_id":self.addId]
       UserDataModel.webServiceToMakeMainAddress(params: para) { (response) in
            if response != nil{
             self.webSerVicessToGetAddressList() }
        }
        
    }
    
    func webServiceCallingToAddAddress() {
        let para = getAllParameter()
        print("para is \(para)")
        UserDataModel.webServiceToAddMyAddress(params: para) { (response) in
            if response != nil{
                self.showAnnouncement(withMessage: response?.message ?? "") {
                    self.webSerVicessToGetAddressList()
                    self.hideMap(toggle: true)
                    self.hideAndShow(toggle: true)
                }
            }
        }
    }
}

//MARK:- Google Places Picker-
//extension EditAddressVC: GMSAutocompleteViewControllerDelegate,GMSAutocompleteFetcherDelegate {
//
//    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
//
//    }
//
//    func didFailAutocompleteWithError(_ error: Error) {
//       print("r")
//    }
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        self.longitude = "\(place.coordinate.longitude)"
//        self.latitude = "\(place.coordinate.latitude)"
//        reverseGeocodeCoordinate(place.coordinate)
//        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude))
//        let target = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
//        mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 30)
//        mapView.camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude,
//                                                  longitude: place.coordinate.longitude,
//                                                  zoom: 15,
//                                                  bearing: 5,
//                                                  viewingAngle: 25)
//        self.txtfAddress.text = place.formattedAddress
//        self.address = place.formattedAddress ?? ""
//        dismiss(animated: true, completion: nil)
//    }
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        // Handle the error
//        print("Error: ", error.localizedDescription)
//    }
//
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        // Dismiss when the user canceled the action
//        dismiss(animated: true, completion: nil)
//    }
//}

extension EditAddressVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.txtfAddress.text = place.formattedAddress ?? ""
        self.lblLocationAddress.text = place.formattedAddress ?? ""
        self.latitude = String(place.coordinate.latitude)
        self.longitude = String(place.coordinate.longitude)
        self.setMarkeronLocation(place.coordinate, title: place.formattedAddress ?? "" ,snippet: "")
        mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 16, bearing: 15, viewingAngle: 0)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("error is \(error)")
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
