//
//  SearchVC.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var clvTab: UICollectionView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var tlvSearchedResult: UITableView!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var txtfSearch:UITextField!
    @IBOutlet weak var lblSearchResult: UILabel!
    @IBOutlet weak var imgFilter: UIImageView!
    
    @IBOutlet weak var viewEmotyMessage: UIView!
    @IBOutlet weak var viewtryDiffkeyWord: UIView!
    @IBOutlet weak var lblToshowKeyWordSearch: UILabel!
    @IBOutlet weak var topLblFilter: UILabel!
    
    var arrTab = [String]()
    var arrOfVendors : [Vendors] = []
    var arrOfPortfolio : [VendorPortfolio] = []

    
    //MARK:- Class Variable here -
       let TabCol =  ColumnFlowLayoutwitFixWidth(cellsPerRow: 1, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 55, cus_width: 100)
    var selectedTab = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txtfSearchWithChar(_ sender: UITextField) {
        self.webServiceToearchWithKeyword()
    }
    
    @IBAction func btnClearSearch(_ sender: Any) {
        self.txtfSearch.text = ""
        self.webServiceToearchWithKeyword()
        selectedTab = 0
        self.clvTab.reloadData()
    }
    
    @IBAction func tryDifferentKyewordAction(_ sender: Any) {
        self.txtfSearch.text = ""
        self.webServiceToearchWithKeyword()
        self.txtfSearch.becomeFirstResponder()
    }
    
}

//MARK:- Custom function here
extension SearchVC{
    func intialConfig(){
        DispatchQueue.main.async {
            self.viewBG.roundedTop(width: 16, height: 16)
        }
        arrTab = ["All","Stylists","Styles"]
        clvTab.collectionViewLayout = self.TabCol
        tlvSearchedResult.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        txtfSearch.attributedPlaceholder = NSAttributedString(string: "Search..",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.webServiceToearchWithKeyword()
    //    self.lblSearchResult.isHidden = true
      //  self.clvTab.isHidden = true
       // self.imgFilter.isHidden = true
    }
}

//MARK:- CollectionView Delegate and DataSource
extension SearchVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return (arrTab.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clvTab.dequeueReusableCell(withReuseIdentifier: "TabCoolectionCell", for: indexPath) as! TabCoolectionCell
        cell.lblTitle.text = self.arrTab[indexPath.row]
        if self.selectedTab == indexPath.row{
            cell.viewBG.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
            cell.lblTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            cell.viewBG.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.lblTitle.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        }
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTab = indexPath.row
        self.clvTab.reloadData()
        self.tlvSearchedResult.reloadData()
    }
    
}

//MARK:- TAbleView DataSource and Delegate
extension SearchVC:UITableViewDataSource,UITableViewDelegate{
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heightOfTableView.constant = self.tlvSearchedResult.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedTab == 0 || selectedTab == 1{
            if self.arrOfVendors.count == 0{
                self.emptyMessage(toogle: false)
            }else{
                self.emptyMessage(toogle: true)
            }
            return self.arrOfVendors.count
        }else {
            if self.arrOfPortfolio.count == 0{
                self.emptyMessage(toogle: false)
            }else{
                self.emptyMessage(toogle: true)
            }
            return self.arrOfPortfolio.count
        }
    }
    
    func emptyMessage(toogle:Bool) {
        viewEmotyMessage.isHidden = toogle
        viewtryDiffkeyWord.isHidden = toogle
        self.tlvSearchedResult.isHidden = !toogle
        self.lblToshowKeyWordSearch.text = "No search results for ‘\(self.txtfSearch.text!)’"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedTab == 2{
            tlvSearchedResult.register(UINib(nibName: "StyleCell", bundle: nil), forCellReuseIdentifier: "StyleCell")
            let cell = tlvSearchedResult.dequeueReusableCell(withIdentifier: "StyleCell", for: indexPath) as! StyleCell
           cell.objPortFolio = self.arrOfPortfolio[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else {
            tlvSearchedResult.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
            let cell = tlvSearchedResult.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
            cell.objSearchVendor = self.arrOfVendors[indexPath.row]
            cell.imgTopBanner.sd_setImage(with: URL(string: self.arrOfVendors[indexPath.row].background_img ?? ""), placeholderImage: UIImage(named: "placeholder"))
            cell.imgUserProfile.sd_setImage(with: URL(string: self.arrOfVendors[indexPath.row].profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            cell.lblName.text = self.arrOfVendors[indexPath.row].user_name ?? ""
            cell.lblUserName.text = self.arrOfVendors[indexPath.row].name ?? ""
                           if self.arrOfVendors[indexPath.row].criminal_record_status! == "1"{
                            cell.imgBDS.image = UIImage(named: "DBS")
                           }else{
                            cell.imgBDS.image = UIImage(named: "not_verified_criminal_record")
                           }
                            if self.arrOfVendors[indexPath.row].is_profile_verify! == "1"{
                                cell.imgVeriFy.image = UIImage(named: "checkIcons")
                           }else{
                            cell.imgVeriFy.image = UIImage(named: "unverified")
                           }
//            cell.lblRating.text = "\(objVendor.vendor_avag_rating ?? 0)"
//                           if self.arrOfVendors[indexPath.row].isBookmark == 1{
//                            cell.imgBookMarked.image = UIImage(named: "bookedmark")
//                           }else{
//                            cell.imgBookMarked.image = UIImage(named: "bookmark")
//                           }
            cell.selectionStyle = .none
            return cell
        }
        //        let cell = tlvSearchedResult.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        //        cell.selectionStyle = .none
        //
        //        return cell
    }
    
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       self.viewWillLayoutSubviews()
  }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedTab == 2{
            
        }else{
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "VendorProfileVC") as! VendorProfileVC
            let venders = self.arrOfVendors[indexPath.row].id ?? ""

            vc.vendor_id  = venders
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)

        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      //  self.reloadTableView()
        if selectedTab == 2{
            return 320
        }else{
            return 240
        }
    }
}

//MARK:- Webservice calling here -
extension SearchVC{
    
    func webServiceToearchWithKeyword(){
        let para = [ParametersKey.search_keyword.rawValue:self.txtfSearch.text!]
        UserDataModel.webServiceSearchWithKeyword(params: para) { (response) in
            if response != nil{
                self.arrOfPortfolio = response?.searchModelObj?.portfolio ?? []
                self.arrOfVendors = response?.searchModelObj?.vendors ?? []
                self.topLblFilter.text = "Found \(self.arrOfVendors.count+self.arrOfPortfolio.count) results for ‘\(self.txtfSearch.text!)’"
                self.tlvSearchedResult.reloadData()
            }
        }
    }
}
