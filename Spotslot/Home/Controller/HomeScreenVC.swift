//
//  HomeScreenVC.swift
//  Spotslot
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import  CoreLocation
import GooglePlaces
//import GooglePlacePicker
import GoogleMaps

class HomeScreenVC: UIViewController {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var clvTab: UICollectionView!
    @IBOutlet weak var clvCatelog: UICollectionView!
    @IBOutlet weak var tlvHome: UITableView!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
   
    //For Details from the list
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var viewGold: UIView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblAvailableCircle: UILabel!
    @IBOutlet weak var lblAvailabity: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgVeriFy: UIImageView!
    @IBOutlet weak var imgBDS: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDistanceFromYou: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblCurrentAddress: UILabel!
    
    //MARK:- for the portfolio
    @IBOutlet weak var imgPortFolio1: UIImageView!
    @IBOutlet weak var imgPortFlio2: UIImageView!
    @IBOutlet weak var imgPortFolio3: UIImageView!
    
    @IBOutlet weak var viewPortFolio1: UIView!
    @IBOutlet weak var viewPortFolio2: UIView!
    @IBOutlet weak var viewPortfolio3: UIView!
    @IBOutlet weak var btnRemanigImages: UIButton!
   

     var portfolio = [Portfolio]()
     var vendor_id = ""
     var filter_key = "1"
    
    //MARK:- Class Variable here -
    let TabCol =  ColumnFlowLayoutwitFixWidth(cellsPerRow: 1, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 55, cus_width: 115)
    
    let TabColForFilter =  ColumnFlowLayoutwitFixWidth(cellsPerRow: 1, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 55, cus_width: 60)
    
    let catelog = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 90)
    
    var arrTab = [String]()
    var arrOfVendorList = [VendorlistModel]()
    var profile_link = ""
    var tabSelected = 1
    var locationManager = CLLocationManager()
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var address = ""

    
    //MARK:- Views Life cycle of the Controller-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intialConfig()
        let para = getAllParameter(filter_key: "1")
        webServicesCallingToGetvendorList(para:para)
        locationConfigure()
        locationUpdation()
        

    }
 
    override func viewWillAppear(_ animated: Bool) {
        hideAndShow(toggle: true)
    }
    
    //Mark:- Hide on touch on bg
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            if touch.view! == self.viewBg{
                hideAndShow(toggle: true)
            }
        }
    }
    ///setupTabBarBackground
    
    
    @IBAction func btnSharevendorsProfiel(_ sender: Any) {
    self.shareLink(link: self.profile_link)
    }
    
    @IBAction func btnBookMarks(_ sender: Any) {
        //do your coding here
    }
    
    @IBAction func pushToSearch(_ sender: Any) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnOpenSideMenu(_ sender: Any) {
        // Dismiss keyboard (optional)
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        // Present the view controller
        self.frostedViewController.presentMenuViewController()
    }
    
    
    @IBAction func btnViewProfile(_ sender: Any) {
        pushToVendorProfile()
    }
    
    @IBAction func btnOpenToGetAddress(_ sender: UIButton) {
        //        let autocompleteController = GMSAutocompleteViewController()
        //        autocompleteController.delegate = self
        /*let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        if #available(iOS 13.0, *) {
            if UIScreen.main.traitCollection.userInterfaceStyle == .dark  {
                autocompleteController.primaryTextColor = UIColor.white
                autocompleteController.secondaryTextColor = UIColor.lightGray
                autocompleteController.tableCellSeparatorColor = UIColor.lightGray
                autocompleteController.tableCellBackgroundColor = UIColor.darkGray
            } else {
                autocompleteController.primaryTextColor = UIColor.black
                autocompleteController.secondaryTextColor = UIColor.lightGray
                autocompleteController.tableCellSeparatorColor = UIColor.lightGray
                autocompleteController.tableCellBackgroundColor = UIColor.white
            }
        }
        present(autocompleteController, animated: true, completion: nil)*/
        
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        /*let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields*/
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
}

//MARK:- Custom function here
extension HomeScreenVC{
    func locationUpdation(){
        //_ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        updateTimer()
    }
    
    @objc func updateTimer() {
        let para = getAllParameterToUpdateLocation()
        webServicesCallingToUpdateLocation(para: para)
    }
    
    func pushToVendorProfile()  {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "VendorProfileVC") as! VendorProfileVC
        vc.vendor_id  = self.vendor_id
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func intialConfig(){
        DispatchQueue.main.async {
            self.viewBG.roundedTop(width: 20, height: 20)
        }
        
        tlvHome.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        arrTab = ["","New","Top Rated","Popular"]
       // self.clvCatelog.collectionViewLayout = self.catelog
       // self.clvTab.collectionViewLayout = self.TabCol
        DispatchQueue.main.async {
            self.imgBanner.roundedTop(width: 16, height: 16)
            self.imgUserProfile.layer.cornerRadius = self.imgUserProfile.frame.height/2
            self.imgUserProfile.borderColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
            self.imgUserProfile.borderWidth = 1.5
            self.viewGold.layer.cornerRadius = self.viewGold.frame.height/2
            self.lblAvailableCircle.layer.cornerRadius = self.lblAvailableCircle.frame.height/2
            self.lblAvailableCircle.clipsToBounds = true
            self.viewPortFolio1.addShadow()
            self.viewPortFolio2.addShadow()
            self.viewPortfolio3.addShadow()
        }
      
    }

    func hideAndShow(toggle:Bool)  {
        self.viewBg.isHidden = toggle
        self.viewDetails.isHidden = toggle
    }
    
    func shareVendorProfiel(indexPaths:IndexPath) {
        self.shareLink(link:self.arrOfVendorList[indexPaths.row].profile_link ?? "")
    }
    
    
//    func shareLink(link:String){
//        let myWebsite = NSURL(string:link)
//        guard let url = myWebsite else {
//            print("nothing found")
//            return
//        }
//        let shareItems:Array = [url]
//        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
//        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
//        self.present(activityViewController, animated: true, completion: nil)
//    }
    
    func setDataOnPopUp(row:Int){
        let obj = self.arrOfVendorList[row]
        imgBanner.sd_setImage(with: URL(string: obj.background_img ?? ""), placeholderImage: UIImage(named: "cover_placeholder"))
        imgUserProfile.sd_setImage(with: URL(string: obj.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        if obj.criminal_record_status! == "1"{
            imgBDS.image = UIImage(named: "DBS")
        }else{
            imgBDS.image = UIImage(named: "not_verified_criminal_record")
        }
        if obj.is_profile_verify! == "1"{
            imgVeriFy.image = UIImage(named: "checkIcons")
        }else{
            imgVeriFy.image = UIImage(named: "unverified")
        }
        if obj.is_available! == "1"{
            self.lblAvailableCircle.isHidden = false
            self.lblAvailabity.isHidden = false
        }else{
            self.lblAvailableCircle.isHidden = true
            self.lblAvailabity.isHidden = true
        }
        self.lblUserName.text = obj.user_name ?? ""
        self.lblFullName.text = obj.name ?? ""
        self.profile_link = obj.profile_link ?? ""
}
    
}

//MARK:- CollectionView Delegate and DataSource
extension HomeScreenVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if self.clvCatelog == collectionView{
//            return self.portfolio.count
//        }else{
            return (arrTab.count)
        //}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if self.clvCatelog == collectionView{
//            clvTab.collectionViewLayout = self.TabColForFilter
//            let cell = clvCatelog.dequeueReusableCell(withReuseIdentifier: "CatelogCell", for: indexPath) as! CatelogCell
//            cell.obj = self.portfolio[indexPath.row]
//            return cell
//        }else{
            if indexPath.row == 0{
                //clvTab.collectionViewLayout = self.TabColForFilter
                let cell = clvTab.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! TabCoolectionCell
                return cell
            }else{
               // clvTab.collectionViewLayout = self.TabCol
                let cell = clvTab.dequeueReusableCell(withReuseIdentifier: "TabCoolectionCell", for: indexPath) as! TabCoolectionCell
                cell.lblTitle.text = self.arrTab[indexPath.row]
                if indexPath.row == tabSelected{
                    cell.viewBG.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
                    cell.lblTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }else{
                    cell.viewBG.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.lblTitle.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 0.8)
                }
                return cell
            }
        //}
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0{
            self.tabSelected = indexPath.row
             filter_key = "1"
            if indexPath.row == 1{
                filter_key = "1"
            }else if indexPath.row == 2{
                filter_key = "2"
            }else if indexPath.row == 3{
                filter_key = "3"
            }
            let para = getAllParameter(filter_key:filter_key)
            webServicesCallingToGetvendorList(para:para)
            self.tlvHome.reloadData()
            self.clvTab.reloadData()
        }else{
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
            vc.hidesBottomBarWhenPushed = true
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
   
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.clvTab == collectionView{
        return CGSize(width: 115, height: 55)
        }else{
        return CGSize(width: 90, height:90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
   // func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if self.clvCatelog != collectionView{
//            let cell = clvTab.cellForItem(at: indexPath) as! TabCoolectionCell
//            if indexPath.row != 0{

//            }
//        }
  //  }
    
}

//MARK:- TAbleView DataSource and Delegate
extension HomeScreenVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // self.heightOfTableView.constant = CGFloat(240*self.arrOfVendorList.count)
        if arrOfVendorList.count == 0 {
            self.tlvHome.setEmptyMessage("Data not found")
        } else {
            self.tlvHome.restore()
        }
        return self.arrOfVendorList.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tlvHome.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeScreenVC.tappedMe))
        cell.imgUserProfile.addGestureRecognizer(tap)
        cell.imgUserProfile.tag = indexPath.row
        cell.imgUserProfile.isUserInteractionEnabled = true
        cell.vendorObj = self.arrOfVendorList[indexPath.row]
        cell.didTapOnButton(didTapToShare: {
            self.shareVendorProfiel(indexPaths:indexPath)
        }) {
            self.toDoBookMark(index:indexPath)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func toDoBookMark(index:IndexPath){
        let id = arrOfVendorList[index.row].id ?? ""
        let para = ["vendor_id":id]
        UserDataModel.webServiceToBookMarkToVendor(params: para) { (response) in
            if response != nil{
                let para = self.getAllParameter(filter_key:self.filter_key)
                self.webServicesCallingToGetvendorList(para:para)
             }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setDataOnPopUp(row: indexPath.row)
        self.portfolio = self.arrOfVendorList[indexPath.row].portfolio ?? []
        self.vendor_id = self.arrOfVendorList[indexPath.row].id ?? ""
        poplateImageOnPortFolio()
        hideAndShow(toggle: false)

    }
    @objc func tappedMe()
    {
      pushToVendorProfile()
    }
    
    func reset()  {
        imgPortFolio1.sd_setImage(with: URL(string:""), placeholderImage: UIImage(named: "placeholder"))
        imgPortFlio2.sd_setImage(with: URL(string:""), placeholderImage: UIImage(named: "placeholder"))
        imgPortFolio3.sd_setImage(with: URL(string:""), placeholderImage: UIImage(named: "placeholder"))
    }
    func poplateImageOnPortFolio(){
        reset()
        if self.portfolio.count != 0{
            for (index, portfolio) in self.portfolio.enumerated() {
                if index == 0 {
                    print(portfolio.image)
                    imgPortFolio1.sd_setImage(with: URL(string: portfolio.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }else if index == 1 {
                    print(portfolio.image)
                    imgPortFlio2.sd_setImage(with: URL(string: portfolio.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }else if index == 2 {
                    print(portfolio.image)
                    imgPortFolio3.sd_setImage(with: URL(string: portfolio.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }
            }
            
            if self.portfolio.count > 3{
                  self.btnRemanigImages.isHidden = false
                self.btnRemanigImages.setTitle("\(self.portfolio.count-3)+", for: .normal)
            }else{
                self.btnRemanigImages.isHidden = true
            }
        }
    }
    
}

extension HomeScreenVC: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
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

/*extension HomeScreenVC:GMSAutocompleteViewControllerDelegate{
    //MARK:- GMSAutocompleteViewControllerDelegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.latitude = place.coordinate.latitude
        self.longitude = place.coordinate.longitude
        self.reverseGeocodeCoordinate(place.coordinate, success: { (addressModelObj) in
           // self.tfAddress.text = addressModelObj.address
           // self.tfCity.text = addressModelObj.city
            //self.tfState.text = addressModelObj.state
            //self.tfCountry.text = addressModelObj.country
           // self.tfPincode.text = addressModelObj.zipCode
        }) { (error) in
            print("error occured",error.localizedDescription)
        }
       /// self.tfAddress.text = place.name
     //   let address = place.formattedAddress?.commaSaparatedComponents
        print("adress is \(address)")
        self.dismiss(animated: true){
            
        }
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        self.showAnnouncement(withMessage: error.localizedDescription)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D, success: @escaping (AddressModel)->(), failure: @escaping (Error)-> ()){
          let geocoder = GMSGeocoder()
          geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
              if let err =  error {
                    failure(err)
                  return
              }
              
              guard let address = response?.firstResult(), let lines = address.lines else {
                  let errorTemp = NSError(domain:"", code:10, userInfo:nil)
                  failure(errorTemp)
                  return
              }
              
              let addrLines = lines.joined(separator: "\n")
              let currentAddress = AddressModel()
              currentAddress.address = addrLines
              currentAddress.city = address.locality ?? ""
              currentAddress.state = address.administrativeArea ?? ""
              currentAddress.country = address.country ?? ""
              currentAddress.zipCode = address.postalCode ?? ""
              currentAddress.lat = String(address.coordinate.latitude)
              currentAddress.lng = String(address.coordinate.longitude)
              success(currentAddress)
              
          }
      }
    
    
    
    
}*/
//MARK:- Delege to get data fromfilter
extension HomeScreenVC:DataPass{
    func dataPass(arrOfVendorList: [VendorlistModel]) {
       self.arrOfVendorList = arrOfVendorList
        self.tlvHome.reloadData()
    }
}

//MARK:- Webservices stuf
extension HomeScreenVC{
    
    func webServicesCallingToGetvendorList(para:[String:Any]){
        print("para is \(para)")
         UserDataModel.webServicesToGetVendorList(params: para) { (responseModel) in
            if responseModel != nil{
                self.arrOfVendorList = responseModel?.VendorlistObject ?? []
                self.tlvHome.reloadData()
            }
        }
    }
    
    func getAllParameter(filter_key:String) ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.latitude.rawValue] = self.latitude
        para[ParametersKey.longitude.rawValue] = self.longitude
        para[ParametersKey.filter_key.rawValue] = filter_key
        return para
    }
    
    func locationConfigure(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
   
    func webServicesCallingToUpdateLocation(para:[String:Any])  {
        UserDataModel.webServicesToUpdateLocation(params: para) { (responseModel) in
            if responseModel != nil{
               //do your code here
            }
        }
    }
    
    func getAllParameterToUpdateLocation() ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.latitude.rawValue] = self.latitude
        para[ParametersKey.longitude.rawValue] = self.longitude
        para[ParametersKey.address.rawValue] = self.address
        return para
    }

}


//Get device Location
extension HomeScreenVC: CLLocationManagerDelegate {
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         print("locations = \(locations)")
        locationManager.stopUpdatingLocation()
        if let cord = locationManager.location?.coordinate {
            self.latitude = cord.latitude
            self.longitude = cord.longitude
            getAddressFromLatLonCoordinate(cord)
        }
    }
    
    //      Mark :-  Reverse geodcode
    func getAddressFromLatLonCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
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
                    self.address = addressString
                    print("Latitudexxx:- \(loc.coordinate.latitude) |||| Longitudexxx:- \(loc.coordinate.longitude)")
                    print(addressString)
                    self.lblCurrentAddress.text = addressString

                }
        })
    }
    
}
