//
//  BookmarksVC.swift
//  Spotslot
//
//  Created by mac on 21/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class BookmarksVC: UIViewController {

    @IBOutlet weak var clvTab: UICollectionView!
    @IBOutlet weak var tlvBookmark: UITableView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var backView: UIView!
    // @IBOutlet weak var heightOFBookMark: NSLayoutConstraint!
    var arrModel = [TabModel]()
    
    var arrFavorite : [Favorite] = []
    var arrBookmark_vendor : [VendorlistModel] = []
    var arrAll : [All] = []
    var tabType = ""
    
    //MARK:- Class Variable here -
    let TabCol =  ColumnFlowLayoutwitFixWidth(cellsPerRow: 1, minimumInteritemSpacing: 5, minimumLineSpacing: 5, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 55, cus_width: 115)
    var arrTab = [String]()
    var isSelectedtab = 0
    var isFromSideMenu: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
    }
    @IBAction func backAction(_ sender: Any) {
        GlobalObj.setRootToDashboard()
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK:- Custom function here
extension BookmarksVC{
    
    func intialConfig(){
        DispatchQueue.main.async {
            self.viewBG.roundedTop(width: 20, height: 20)
        }
        tlvBookmark.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        arrTab = ["All","Stylists","Styles"]
        self.clvTab.collectionViewLayout = self.TabCol
        storeData()
        webServicesCallingToGetAllBookedMarked()
        
        backView.isHidden =  isFromSideMenu ? false : true
    }
    
    func storeData()  {
        let obj1 = TabModel(isSelectedTab: true,title:"All")
        self.arrModel.append(obj1)
        let obj2 = TabModel(isSelectedTab: false,title:"Stylists")
        self.arrModel.append(obj2)
        let obj3 = TabModel(isSelectedTab: false,title:"Styles")
        self.arrModel.append(obj3)
        self.clvTab.reloadData()
    }
}

//MARK:- TAbleView DataSource and Delegate
extension BookmarksVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSelectedtab == 0{//for all
            return self.arrAll.count
        }else if isSelectedtab == 1{//stylist
            return self.arrBookmark_vendor.count
        }else{//for styles
            return self.arrFavorite.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSelectedtab == 2{
            tlvBookmark.register(UINib(nibName: "StyleCell", bundle: nil), forCellReuseIdentifier: "StyleCell")
            let cell = tlvBookmark.dequeueReusableCell(withIdentifier: "StyleCell", for: indexPath) as! StyleCell
            cell.objFavourite = self.arrFavorite[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else if isSelectedtab == 1{
            tlvBookmark.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
            let cell = tlvBookmark.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
            cell.vendorObj = self.arrBookmark_vendor[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else{
            if arrAll[indexPath.row].mark_type == "style"{
                  tlvBookmark.register(UINib(nibName: "StyleCell", bundle: nil), forCellReuseIdentifier: "StyleCell")
                let cell = tlvBookmark.dequeueReusableCell(withIdentifier: "StyleCell", for: indexPath) as! StyleCell
                cell.objAll = self.arrAll[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }else {
                 tlvBookmark.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
                let cell = tlvBookmark.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
                cell.objAll = self.arrAll[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      //  self.reloadTableView()
        if isSelectedtab == 2{
            return 320
        }else{
            return 240
        }
    }
 
}

//MARK:- CollectionView Delegate and DataSource
extension BookmarksVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return (arrModel.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        clvTab.collectionViewLayout = self.TabCol
        let cell = clvTab.dequeueReusableCell(withReuseIdentifier: "TabCoolectionCell", for: indexPath) as! TabCoolectionCell
        cell.lblTitle.text = self.arrModel[indexPath.row].title
        if isSelectedtab == indexPath.row{
            cell.viewBG.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
            cell.lblTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            cell.viewBG.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.lblTitle.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 0.5)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.isSelectedtab = indexPath.row
        if indexPath.row == 2{
            tlvBookmark.register(UINib(nibName: "StyleCell", bundle: nil), forCellReuseIdentifier: "StyleCell")
        }else{
            tlvBookmark.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        }
        DispatchQueue.main.async {
            self.tlvBookmark.reloadData()
        }
        self.clvTab.reloadData()
        webServicesCallingToGetAllBookedMarked()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = clvTab.cellForItem(at: indexPath) as! TabCoolectionCell
        cell.viewBG.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lblTitle.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 0.8)
     //   self.arrModel[indexPath.row].isSelectedTab.toggle()
    }
}

//MARK:- Webservice calling here -
extension BookmarksVC{
func webServicesCallingToGetAllBookedMarked(){
    UserDataModel.webServiceToGetAllBookedList(params: [:]) { (response) in
        if response != nil{
            self.arrFavorite = response?.objBookMarkModel?.favorite ?? []
            self.arrBookmark_vendor = response?.objBookMarkModel?.bookmark_vendor ?? []
            self.arrAll  = response?.objBookMarkModel?.all ?? []
            self.tlvBookmark.reloadData()
        }
    }
        
}
}
