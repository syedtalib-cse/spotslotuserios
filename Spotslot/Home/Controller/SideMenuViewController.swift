//
//  SideMenuViewController.swift
//  DemoSideMenuBySunil
//
//  Created by Honey on 16/07/20.
//  Copyright © 2020 Honey. All rights reserved.
//

import UIKit
import REFrostedViewController

class SideMenuViewController: UIViewController{

    //MARK:- IBOUTLet's Of The Controller-
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    //@IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    //MARK:- Class Variable-
    fileprivate let arrOfCustomerMenu = SideMenu.getAllMenus()
    var IsTypecustomer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topColor = #colorLiteral(red: 0.1176470588, green: 0.2235294118, blue: 0.2745098039, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.1215686275, green: 0.1764705882, blue: 0.2039215686, alpha: 1)
        self.view.setGradientBackgrounds(colorTop: topColor, colorBottom: bottomColor, radius: 0)
        if let profile_img  = SharedPreference.getUserData().profile_image{
            self.imgViewUser.sd_setImage(with: URL(string:profile_img), placeholderImage: UIImage(named: "placeholder"))
        }
        if let vendorName  = SharedPreference.getUserData().name{
            lblUserName.text = vendorName
        }
        
    }

    
    
    @IBAction func btnLogOut(_ sender: Any) {
        self.showAnnouncementYesOrNo(withMessage: "Do you want to logout?") {
            UserDataModel.webServiceToLogOut(params: [:]) { (response) in
                if response != nil{
                    UserDefaults.standard.setValue("", forKey:GenralText.isLoggedIn.rawValue)
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let rootVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC //root
//                    let navigatCon = UINavigationController(rootViewController: rootVC)
//                    navigatCon.isNavigationBarHidden = true
//                    self.present(navigatCon, animated: true, completion: nil)
                    GlobalObj.Logout()
                }
            }
        }
        
    }
    
    @IBAction func btnClose(_ sender: Any) {
         frostedViewController.hideMenuViewController()
    }
    
    
} //Class End Here-

//MARK:- UITableViewDelegate,UITableViewDataSource-
extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource {
    
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return    arrOfCustomerMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.imgViewConIcon.image = arrOfCustomerMenu[indexPath.row].controllerImg
        cell.lblControllerName.text = arrOfCustomerMenu[indexPath.row].controllerName
        let backgroundView = UIView()
        cell.selectionStyle = .none
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    //  Converted to Swift 5.3 by Swiftify v5.3.19197 - https://swiftify.com/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
        if indexPath.section == 0 && indexPath.row == 0{
            let vc = UIStoryboard(name: "Bookmarks", bundle: nil).instantiateViewController(withIdentifier: "BookmarksVC") as! BookmarksVC
            vc.isFromSideMenu = true
            navigationController.viewControllers = [vc]
            self.frostedViewController.contentViewController = navigationController
            
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PaymentListVC") as! PaymentListVC
            /*let manageBankAccountRouter = ManageBankAccountsRouterImplementation(manageBankAccountCardsVC: vc)
             vc.presenter = ManageBankAccountsPresenterImplementation(router: manageBankAccountRouter)*/
            navigationController.viewControllers = [vc]
            self.frostedViewController.contentViewController = navigationController
            
            
        } else if indexPath.section == 0 && indexPath.row == 2 {
            
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            vc.isFromSideMenu = true
            navigationController.viewControllers = [vc]
            self.frostedViewController.contentViewController = navigationController
        }
        
        frostedViewController.hideMenuViewController()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

}

//model For The SideMenu

fileprivate struct SideMenu {
    var controllerName:String
    var controllerImg:UIImage
    
    init(conName:String,conIcon:UIImage) {
        self.controllerName = conName
        self.controllerImg = conIcon
    }
    
    static func getAllMenus()-> [SideMenu] {
        let m1 = SideMenu(conName: "Appointments/Bookings", conIcon: #imageLiteral(resourceName: "calander"))
        let m2 = SideMenu(conName: "Payments", conIcon: #imageLiteral(resourceName: "Payments"))
        let m3 = SideMenu(conName: "Settings", conIcon:#imageLiteral(resourceName: "settings"))
        let m4 = SideMenu(conName: "Help", conIcon: #imageLiteral(resourceName: "help"))
        return [m1,m2,m3,m4]
    }
}

