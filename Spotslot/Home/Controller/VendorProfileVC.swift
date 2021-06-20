//
//  VendorProfileVC.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

class VendorProfileVC: UIViewController {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var clvReview: UICollectionView!
    @IBOutlet weak var viewService: UIView!
    @IBOutlet weak var tlvhair: UITableView!
    @IBOutlet weak var tlvBeard: UITableView!
    @IBOutlet weak var hrightOfHairTlv: NSLayoutConstraint!
    @IBOutlet weak var heightofBeardTlv: NSLayoutConstraint!
    @IBOutlet weak var clvportfolio: UICollectionView!
    @IBOutlet weak var viewPortfolio: UIView!
    
    //top
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgIsCleanForCriminalRecord: UIImageView!
    @IBOutlet weak var imgIsVerified: UIImageView!
    @IBOutlet weak var lblTierName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    //About
    @IBOutlet weak var lblTotalRatedUser: UILabel!
    @IBOutlet weak var lblAvrageRating: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    
    //tab
    @IBOutlet weak var btnportfolio: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnAbout: UIButton!
    
    //services
    @IBOutlet weak var lblNumberoFpeople: UILabel!
    
    //Slider
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var viewSlider: UIView!
    @IBOutlet weak var viewPortfolioSlider: UIView!
    @IBOutlet weak var lblCounterforSlider: UILabel!
    @IBOutlet weak var imgBookMarked: UIImageView!
    @IBOutlet weak var lblMondayToFriday: UILabel!
    @IBOutlet weak var lblSaturday: UILabel!
    @IBOutlet weak var lblSunday: UILabel!
    @IBOutlet weak var btnBookVendor: UIButton!
    @IBOutlet weak var viewSelectSlot: UIView!
    
    //For slider stif here
    var numberOfPeople = 1
    var rating_list : [Rating_list] = []
    var services : [Services] = []
    var arrOfportfolio : [VendorPortfolio] = []
    var locationManager = CLLocationManager()
    var selectedServices:Service_list?
    var dataDic = [String:Any]()
    var isSelectedService = false
    
    //For the slider
    let portFolio = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 100)
    
    let slider = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 450)
    
    var vendor_id = ""
    var selectedIndex:IndexPath?
    
    var timer = Timer()
    var counter = 0
    var mainAddress: CoverageDetail?
    
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
        
//        vendor_id = UserDefaults.standard.value(forKey: "vendor_id") as! String
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         callWebservices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureClv()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnPortFolio(_ sender: Any) {
        self.isHiden(about: true, service: true, portfolio: false)
        setBackColorTobtn(about: true, service: true, portfolio: false)
        viewSelectSlot.isHidden =  true
        self.clvportfolio.reloadData()
    }
    
    @IBAction func btnService(_ sender: Any) {
         self.isHiden(about: true, service: false, portfolio: true)
         setBackColorTobtn(about: true, service: false, portfolio: true)
          viewSelectSlot.isHidden = false
        self.tlvhair.reloadData()
    }
    
    @IBAction func btnAbout(_ sender: Any) {
         self.isHiden(about: false, service: true, portfolio: true)
        setBackColorTobtn(about: false, service: true, portfolio: true)
          viewSelectSlot.isHidden = true
    }
    
    @IBAction func btnClose(_ sender: Any) {
        viewSlider.isHidden = true
        viewPortfolioSlider.isHidden = true
    }
    
    @IBAction func btnSelectSlot(_ sender: Any) {
        if  self.isSelectedService, mainAddress != nil {
            dataDic[ParametersKey.no_of_person.rawValue] =  self.lblNumberoFpeople.text!
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ApointmentCalandar") as! ApointmentCalandar
            vc.hidesBottomBarWhenPushed = true
            vc.dicData = self.dataDic
            vc.vendorId = self.vendor_id
            vc.mainAddress = mainAddress
            
            vc.latitude = self.latitude
            vc.longitude = self.longitude
            vc.address = self.address
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            if mainAddress == nil {
                self.showAnnouncement(withMessage: "Vendor doesn't fill all details, please choose another vendor")
            }else {
                self.showAnnouncement(withMessage: "Please select services to proceed booking")
            }
        }
    }
    
    
    @IBAction func btnPlus(_ sender: Any) {
        numberOfPeople = numberOfPeople+1
        self.lblNumberoFpeople.text = "\(numberOfPeople)"
    }
    
    @IBAction func btnMinus(_ sender: Any) {
        if numberOfPeople > 1{
            numberOfPeople = numberOfPeople-1
            self.lblNumberoFpeople.text = "\(numberOfPeople)"
        }
        
    }
    
    @IBAction func btnShare(_ sender: Any) {
        self.shareLink(link: "https://www.google.com/")
    }

    @IBAction func btnBookMark(_ sender: Any) {
      toDoBookMark()
    }
    
    @IBAction func btnBookVendor(_ sender: UIButton) {
        self.isHiden(about: true, service: false, portfolio: true)
        setBackColorTobtn(about: true, service: false, portfolio: true)
        viewSelectSlot.isHidden = false
        self.tlvhair.reloadData()
    }
    
    deinit {
        self.timer.invalidate()
    }
    
}

//MARK:- Custom function
extension VendorProfileVC{
    
    func toDoBookMark(){
         let para = ["vendor_id":self.vendor_id]
         UserDataModel.webServiceToBookMarkToVendor(params: para) { (response) in
             if response != nil{
                 //let para = self.getAllParameter(filter_key:self.filter_key)
                 //self.webServicesCallingToGetvendorList(para:para)
                self.callWebservices()
              }
         }
     }
    
    
    func intialConfig(){
        initiaResetUIDetails()
        self.isHiden(about: false, service: true, portfolio: true)
        DispatchQueue.main.async {
            self.viewBG.roundedTop(width: 16, height: 16)
            self.viewService.roundedTop(width: 16, height: 16)
            self.viewPortfolio.roundedTop(width: 16, height: 16)
            self.imgUser.cornerRadius = self.imgUser.frame.height/2
        }
        //self.slider.scrollDirection = .horizontal
        //sliderCollectionView.collectionViewLayout = self.slider
        configureClv()
        clvportfolio.collectionViewLayout = portFolio
        viewSlider.isHidden = true
        viewPortfolioSlider.isHidden = true
        viewSelectSlot.isHidden = true
        self.forSlidePortFolio()
        DispatchQueue.main.async {
            self.viewSelectSlot.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 0), opacity: 1, shadowRadius: 0, cornerRadius: 0, corners: [.topRight,.topLeft])
        }
    }
    
    @objc func changeImage()  {
        /*if counter < arrOfportfolio.count {
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {*/
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        //}
        lblCounterforSlider.text = "\(counter) of \(arrOfportfolio.count)"
    }
    
    
    func forSlidePortFolio(){
        pageView.numberOfPages = arrOfportfolio.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer.invalidate()
            //self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            self.changeImage()
        }
    }
    
    func isHiden(about:Bool,service:Bool,portfolio:Bool)  {
        self.viewBG.isHidden = about
        self.viewService.isHidden = service
        self.viewPortfolio.isHidden = portfolio
    }
    
    func setBackColorTobtn(about:Bool,service:Bool,portfolio:Bool)  {
        let colorService = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        if !about{
            self.btnAbout.backgroundColor = #colorLiteral(red: 0.02360710129, green: 0.6167666912, blue: 0.639928937, alpha: 1)
            self.btnAbout.setTitleColor(UIColor.white, for: .normal)
            
            self.btnService.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnService.setTitleColor(colorService, for: .normal)
            
            self.btnportfolio.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnportfolio.setTitleColor(colorService, for: .normal)
        }else if !service{
            self.btnAbout.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnAbout.setTitleColor(colorService, for: .normal)
            
            self.btnService.backgroundColor = #colorLiteral(red: 0.02360710129, green: 0.6167666912, blue: 0.639928937, alpha: 1)
            self.btnService.setTitleColor(UIColor.white, for: .normal)
            
            self.btnportfolio.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnportfolio.setTitleColor(colorService, for: .normal)
            
        }else if !portfolio{
            self.btnAbout.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnAbout.setTitleColor(colorService, for: .normal)
            
            self.btnService.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnService.setTitleColor(colorService, for: .normal)
            
            self.btnportfolio.backgroundColor = #colorLiteral(red: 0.02360710129, green: 0.6167666912, blue: 0.639928937, alpha: 1)
            self.btnportfolio.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func callWebservices(){
        let para = getAllParameter()
        self.webServicesCallingToGetvendorDetails(para: para)
    }
    
    //to populate data for the profile
    func toSetDataOnProfile(vendorAbout:About){
        imgCover.sd_setImage(with: URL(string: vendorAbout.background_img ?? ""), placeholderImage: UIImage(named: "cover_placeholder"))
        imgUser.sd_setImage(with: URL(string: vendorAbout.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        lblname.text = vendorAbout.specialize ?? ""
        lblUserName.text = vendorAbout.user_name ?? ""
        btnBookVendor.setTitle("Book \(vendorAbout.user_name ?? "")", for: .normal)
        if (vendorAbout.criminal_record_status ?? "") == "1"{
            imgIsCleanForCriminalRecord.image = UIImage(named: "DBS")
        }else{
            imgIsCleanForCriminalRecord.image = UIImage(named: "not_verified_criminal_record")
        }
        if (vendorAbout.is_profile_verify ?? "") == "1"{
            imgIsVerified.image = UIImage(named: "checkIcons")
        }else{
            imgIsVerified.image = nil //UIImage(named: "unverified")
        }
        lblRating.text = "\(vendorAbout.avag_rating ?? 0)"
        self.rating_list = vendorAbout.rating_list ?? []
        lblTotalRatedUser.text = "(\(vendorAbout.total_rate_user ?? 0))"
        lblAvrageRating.text = "\(vendorAbout.avag_rating ?? 0)"
        lblBio.text = vendorAbout.bio ?? ""
        dataDic["about"] = vendorAbout
        if vendorAbout.isBookmark == 1{
            imgBookMarked.image = UIImage(named: "bookedmark")
        }else{
            imgBookMarked.image = UIImage(named: "bookmark")
        }
        self.clvReview.reloadData()
      
   }
    
    private func initiaResetUIDetails() {
        imgCover.image = UIImage(named: "cover_placeholder")
        imgUser.image = UIImage(named: "placeholder")
        lblname.text = ""
        lblUserName.text = ""
        btnBookVendor.setTitle("Book)", for: .normal)
        imgIsCleanForCriminalRecord.image = UIImage(named: "not_verified_criminal_record")
        imgIsVerified.image = nil //UIImage(named: "unverified")
        lblRating.text = "0"
        lblTotalRatedUser.text = "0"
        lblAvrageRating.text = "0"
        lblBio.text = ""
        imgBookMarked.image = UIImage(named: "bookmark")
        lblLanguage.text = ""
        lblMondayToFriday.text = ""
        lblSaturday.text = ""
        lblSunday.text = ""
    }
    
    private func setBusinessHoursDetails(_ model: BuisnessHourDetail?) {
        lblMondayToFriday.text = model?.monFri ?? ""
        lblSaturday.text = model?.sat ?? ""
        lblSunday.text = model?.sun ?? ""
    }
    
    private func setLanguages(_ languages: [LanguageModel]? ) {
        
        let selectedLanguagesNames = languages?.reduce([String](), { (result, language) -> [String] in
            var _result = result
            if language.languageName != nil {
                _result.append(language.languageName ?? "")
            }
            
            return _result
        }).joined(separator: ", ")
        lblLanguage.text = selectedLanguagesNames
    }
    
    private func setMainAddress(coverageDetails: CoverageDetail?) {
        self.mainAddress = coverageDetails
    }
    
    private func setLikeDislikePortfoliosWith(status: Bool, cell: PortfolioSliderCollectionViewCell) {
        guard let indexPath = sliderCollectionView.indexPath(for: cell) else {return}
        self.webServiceForLikeDislike(updateIndexPath: indexPath)
    }
}


//MARK:-ollectionView Delegate and DataSource
extension VendorProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.clvportfolio == collectionView{
            return self.arrOfportfolio.count
        }else if self.sliderCollectionView == collectionView{
              return arrOfportfolio.count
        }   else{
            return rating_list.count
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.clvportfolio == collectionView{
            let cell = clvportfolio.dequeueReusableCell(withReuseIdentifier: "PortfoliCell", for: indexPath) as! PortfoliCell
            
            cell.objVendorPortfolio = self.arrOfportfolio[indexPath.row]
            cell.imgPortfolio.clipsToBounds = true
            return cell
        }else if self.sliderCollectionView == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioSliderCollectionViewCell", for: indexPath) as! PortfolioSliderCollectionViewCell
            let obj = arrOfportfolio[indexPath.row]
            cell.objVendorPortfolio = obj
            //cell.imgPortfolio.sd_setImage(with: URL(string: obj.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            cell.imgPortfolio.clipsToBounds = true
            cell.completionHandler = { [weak self] (status, cell) in
                self?.setLikeDislikePortfoliosWith(status: status, cell: cell)
            }
            
            return cell
        }else{
            let cell = clvReview.dequeueReusableCell(withReuseIdentifier: "VendorReviewCell", for: indexPath) as! VendorReviewCell
            cell.objRating = self.rating_list[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.clvportfolio == collectionView{
            viewSlider.isHidden = false
            viewPortfolioSlider.isHidden = false
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in sliderCollectionView.visibleCells {
            let indexPath = sliderCollectionView.indexPath(for: cell)
            //print(indexPath?.item)
            let scrollCount = indexPath?.item ?? 0
            //print("scrollCount:- \(scrollCount + 1)")
            pageView.currentPage = scrollCount
            lblCounterforSlider.text = "\(scrollCount + 1) of \(arrOfportfolio.count)"
            
        }
    }
    
}

//MARK:- Delegate and DataSource
extension VendorProfileVC:UITableViewDelegate,UITableViewDataSource{
    override func viewWillLayoutSubviews() {
           super.updateViewConstraints()
      //  self.hrightOfHairTlv.constant = self.tlvhair.contentSize.height
       // self.heightofBeardTlv.constant = self.tlvBeard.contentSize.height
  }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.services.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DispatchQueue.main.async {
            //self.hrightOfHairTlv.constant = self.tlvhair.contentSize.height
        }
        if services.count != 0 {
            if self.services[section].service_list != nil{
                if self.services[section].category_name! == "Group Offers"{
                    tlvhair.register(UINib(nibName: "GroupListCell", bundle: nil), forCellReuseIdentifier: "GroupListCell")
                }else{
                    tlvhair.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
                }
                return self.services[section].service_list!.count
            }else{
                return 0
            }
            
        }else{
            return 0
        }
    }
    
    func selectServices(indexpath:IndexPath){
        if self.services[indexpath.section].service_list != nil{
         dataDic["service"] = self.services[indexpath.section].service_list?[indexpath.row]
         self.isSelectedService = true
         }
        self.selectedIndex = indexpath
        self.tlvhair.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.services[indexPath.section].category_name! == "Group Offers"{
            let cell = tlvhair.dequeueReusableCell(withIdentifier: "GroupListCell", for: indexPath) as! GroupListCell
            cell.objData = self.services[indexPath.section].service_list![indexPath.row]
            cell.didTapToSelect {
                self.selectServices(indexpath: indexPath)
            }
            if selectedIndex != nil{
                if selectedIndex!.section == indexPath.section{
                    if selectedIndex!.row == indexPath.row{
                        cell.imgRadio.image = UIImage(named: "services_radio_btn")
                        cell.lblGroupName.textColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
                    }else{
                        cell.lblGroupName.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
                        cell.imgRadio.image = UIImage(named: "radio-button")
                    }
                }else{
                    cell.lblGroupName.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
                    cell.imgRadio.image = UIImage(named: "radio-button")
                }
            }
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tlvhair.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            cell.objServices = self.services[indexPath.section].service_list![indexPath.row]
            cell.didTapToSelect {
                self.selectServices(indexpath: indexPath)
            }
            if selectedIndex != nil{
                if selectedIndex!.section == indexPath.section{
                    if selectedIndex!.row == indexPath.row{
                        cell.imgRadio.image = UIImage(named: "services_radio_btn")
                        cell.lblServiceName.textColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
                    }else{
                        cell.lblServiceName.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
                        cell.imgRadio.image = UIImage(named: "radio-button")
                    }
                }else{
                    cell.lblServiceName.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
                    cell.imgRadio.image = UIImage(named: "radio-button")
                }
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          self.viewWillLayoutSubviews()
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.services[indexPath.section].service_list != nil{
            dataDic["service"] = self.services[indexPath.section].service_list?[indexPath.row]
            self.isSelectedService = true
        }
        self.selectedIndex = indexPath
        self.tlvhair.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 5, y: 10, width:
            tableView.bounds.size.width, height: 20))
        headerLabel.font = UIFont(name: "OpenSans-SemiBold.ttf", size: 22)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.services[section].category_name ?? ""
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

//MARK:- Webservice calling here -
extension VendorProfileVC{
    func webServicesCallingToGetvendorDetails(para:[String:Any])  {
        let para = getAllParameter()
        UserDataModel.webServicesToGetVendorProfiledata(params: para) { (responseModel) in
            if responseModel != nil{
                print("repsonse is \(responseModel?.VendorProfile?.about)")
                self.toSetDataOnProfile(vendorAbout: responseModel?.VendorProfile?.about ?? About())
                self.setBusinessHoursDetails(responseModel?.VendorProfile?.buisness_hours)
                self.setLanguages(responseModel?.VendorProfile?.languages)
                self.setMainAddress(coverageDetails: responseModel?.VendorProfile?.setcoverage)
                self.services = self.filterServices(responseModel?.VendorProfile?.services ?? [])
                self.arrOfportfolio = responseModel?.VendorProfile?.portfolio ?? []
                if self.arrOfportfolio.count != 0{
                    self.forSlidePortFolio()
                }
                self.sliderCollectionView.reloadData()
                self.clvportfolio.reloadData()
            }
        }
    }
    
    func getAllParameter() ->[String:Any] {
        var para = [String:Any]()
        para[ParametersKey.vendor_id.rawValue] = self.vendor_id
        return para
    }
    
    private func filterServices(_ services: [Services]) -> [Services] {
        let finalServices = services.filter { (service) -> Bool in
            return !(service.service_list?.isEmpty ?? true) ? true : false
        }
        return finalServices
    }
    
    func webServiceForLikeDislike(updateIndexPath: IndexPath){
        let para = ["portfolio_style_id" :arrOfportfolio[updateIndexPath.item].id ?? "", "vendor_id": arrOfportfolio[updateIndexPath.item].vendor_id ?? ""]
        UserDataModel.webServiceLikeDislikePortfolios(params: para) { [weak self] (response) in
            if response != nil{
                guard let self = self/*, response?.data != nil*/ else {return}
                if let isFavourite = self.arrOfportfolio[updateIndexPath.item].isFavorite {
                    self.arrOfportfolio[updateIndexPath.item].isFavorite = isFavourite == 0 ? 1 : 0
                    self.sliderCollectionView.reloadItems(at: [updateIndexPath])
                }
               
            }
        }
    }

}


extension VendorProfileVC{
func configureClv()  {
    let screenRect = UIScreen.main.bounds
    let screenWidth = screenRect.size.width
    let cellSize = CGSize(width:screenWidth-50, height:160)
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal //.horizontal
    layout.itemSize = cellSize
    layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    layout.minimumLineSpacing = 1.0
    layout.minimumInteritemSpacing = 1.0
    clvReview.setCollectionViewLayout(layout, animated: true)
    
    let layout1 = UICollectionViewFlowLayout()
    layout1.scrollDirection = .horizontal //.horizontal
    layout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout1.minimumLineSpacing = 0.0
    layout1.minimumInteritemSpacing = 0.0
    let cellSizeSlider = CGSize(width:self.sliderCollectionView.frame.width, height:self.sliderCollectionView.frame.height)
    layout1.itemSize = cellSizeSlider
    sliderCollectionView.setCollectionViewLayout(layout1, animated: true)
}
}

/*
 func configureClv()  {
      let screenRect = UIScreen.main.bounds
      let screenWidth = screenRect.size.width
      let cellSize = CGSize(width:screenWidth-50, height:160)
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal //.horizontal
      layout.itemSize = cellSize
      layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom:5, right:5)
      layout.minimumLineSpacing = 1.0
      layout.minimumInteritemSpacing = 1.0
      clvReview.setCollectionViewLayout(layout, animated: true)
      let cellSizeSlider = CGSize(width:screenWidth-60, height:self.sliderCollectionView.frame.height-100)
      layout.itemSize = cellSizeSlider
      sliderCollectionView.setCollectionViewLayout(layout, animated: true)
  }
  
 
 
 */
