//
//  Global.swift
//  Spotslot
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//
import Foundation
import UIKit
import REFrostedViewController
import KRProgressHUD
let GlobalObj = Global()
class Global {
    
    //MARK: - Show alert method
       func showAlertVC(title:String,message:String,controller:UIViewController) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let subView = alertController.view.subviews.first!
           let alertContentView = subView.subviews.first!
           alertContentView.backgroundColor = UIColor.gray
           alertContentView.layer.cornerRadius = 20
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           controller.present(alertController, animated: true, completion: nil)
        
       }
       
       //MARK:- Alert for Login
       func alertAndPopToPreviousController(title:String,message:String,controller:UIViewController,isForRoot:Bool){
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let subView = alertController.view.subviews.first!
           let alertContentView = subView.subviews.first!
           alertContentView.backgroundColor = UIColor.gray
           alertContentView.layer.cornerRadius = 20
           let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
               UIAlertAction in
               if isForRoot == true{
                   controller.navigationController?.popToRootViewController(animated: true)
               }else{
                   controller.navigationController?.popViewController(animated: true)
               }
           }
           alertController.addAction(OKAction)
           controller.present(alertController, animated: true, completion: nil)
       }
       
       //MARK:- Alert with completion handler and alert style
       func displayAlertWithHandler(with title: String?, message: String?, buttons: [String], viewobj:UIViewController,buttonStyles: [UIAlertAction.Style] = [], handler: @escaping (String) -> Void) {
           DispatchQueue.main.async {
               let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
               for i in 0 ..< buttons.count {
                   let style: UIAlertAction.Style = buttonStyles.indices.contains(i) ? buttonStyles[i] : .default
                   let buttonTitle = buttons[i]
                   let action = UIAlertAction(title: buttonTitle, style: style) { (_) in
                       handler(buttonTitle)
                   }
                   alertController.addAction(action)
               }
               viewobj.present(alertController, animated: true)
           }
       }
        
       //MARK:- Alert with completion handler and sheet style
       func displayAlertWithHandlerwithSheetStyle(with title: String?, message: String?, buttons: [String], viewobj:UIViewController,buttonStyles: [UIAlertAction.Style], handler: @escaping (String) -> Void) {
           DispatchQueue.main.async {
               let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
               for i in 0 ..< buttons.count {
                   let style: UIAlertAction.Style = buttonStyles.indices.contains(i) ? buttonStyles[i] : .default
                   let buttonTitle = buttons[i]
                   let action = UIAlertAction(title: buttonTitle, style: style) { (_) in
                       handler(buttonTitle)
                   }
                   alertController.addAction(action)
               }
               viewobj.present(alertController, animated: true)
           }
       }
    
//    func displayAlertWithHandlerwithSheetStyleWithThreeOption(with title: String?, message: String?, buttons: [String], viewobj:UIViewController,buttonStyles: [UIAlertAction.Style], handler: @escaping (String) -> Void) {
//              DispatchQueue.main.async {
//                  let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
//                  for i in 0 ..< buttons.count {
//                      let style: UIAlertAction.Style = buttonStyles.indices.contains(i) ? buttonStyles[i] : .default
//                      let buttonTitle = buttons[i]
//                      let action = UIAlertAction(title: buttonTitle, style: style) { (_) in
//                          handler(buttonTitle)
//                      }
//                      alertController.addAction(action)
//                  }
//                  viewobj.present(alertController, animated: true)
//              }
//          }
//    
    
//    func setRootToDashboard(){
//
//           guard let tabBarController = UIStoryboard.init(name: AppStoryboard.Dashboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TabbarVC") as? TabbarVC else {
//               return
//           }
//
//           guard let leftViewController = UIStoryboard.init(name: AppStoryboard.SideMenu.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC else {
//               return
//           }
//           let nvc: UINavigationController = UINavigationController(rootViewController: tabBarController)
//
//           nvc.isNavigationBarHidden = true
//           let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
//           slideMenuController.automaticallyAdjustsScrollViewInsets = true
//           SlideMenuOptions.contentViewScale = 1
//           let appDelegate = UIApplication.shared.delegate as! AppDelegate
//           appDelegate.window?.rootViewController = slideMenuController
//           appDelegate.window?.makeKeyAndVisible()
//       }
       
      
       func manageNavigationForAlreadyLoggedIn(){
           if let isLoggedInValue = UserDefaults.standard.value(forKey: GenralText.isLoggedIn.rawValue) as? String{
            if isLoggedInValue == GenralText.isLoggedIn.rawValue{
                self.setRootToDashboard()
            }else{
                self.Logout()
            }
           }else{
            setRootToLogin()
           }
       }
    
    func setRootToDashboard(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "rootController") as! RootViewController
        let navigationController = storyboard.instantiateViewController(withIdentifier: "JBTabBarController") as! WaveTabBarController
        let sideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController")
        rootVC.contentViewController = navigationController
        rootVC.menuViewController =  sideMenuVC
        UIApplication.shared.windows.first?.rootViewController = rootVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func setRootToLogin(){
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//      let rootVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC //root
      let rootVC = storyboard.instantiateViewController(withIdentifier: "navChoose") as! UINavigationController
      UIApplication.shared.windows.first?.rootViewController = rootVC
      UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    func Logout(){
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//      let rootVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC //root
      let rootVC = storyboard.instantiateViewController(withIdentifier: "navLogin") as! UINavigationController
      UIApplication.shared.windows.first?.rootViewController = rootVC
      UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func ConevertRequriedDateFormate(dateStr:String) ->String {
        var str = ""
        let dateFormate = Global.serverFormate()
        let date = dateFormate.date(from:dateStr)
        let getDate = Global.getDateFormate()
        if date != nil{
            let strDate = getDate.string(from: date!)
           str = strDate
        }else{
            return str
        }
        return str
    }
    
    class func getDateFormate() -> DateFormatter {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMM yyyy"
          dateFormatter.timeZone = TimeZone(abbreviation: "IST")!
          return dateFormatter
      }
      
    class func serverFormate()->DateFormatter {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
          return dateFormatter
      }
    
     

    
    // MARK: - Loading-
    func displayLoader(_ shouldDisplay: Bool, show: Bool) {
        if shouldDisplay {
            if show {
                // display loader
                presentIndicator()
            } else {
                // hide loader
                dismissIndicator()
            }
        }
    }
    
    //Present Loader
    func presentIndicator() {
        DispatchQueue.main.async {
           UIApplication.shared.windows.first?.isUserInteractionEnabled = false
            KRProgressHUD.show()
        }
    }
    
    //MARK:-Loader Function
    func dismissIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.isUserInteractionEnabled = true
            KRProgressHUD.dismiss()
        }
    }
    
    
 
    class func getAmPmDateFormate() -> DateFormatter {
          let dateFormatter = DateFormatter()
          //if some one want 12AM,5PM then use "hh mm a"
          //if some one want 00AM,17PM then use "HH mm a"
          dateFormatter.dateFormat = "hh:mm a"
          return dateFormatter
      }
      
//      class func getDateFormate() -> DateFormatter {
//          let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = "dd MMM yyyy"
//          dateFormatter.timeZone = TimeZone(abbreviation: "IST")!
//          return dateFormatter
//      }
      
      class func getUserDateFormate() -> DateFormatter {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd-MM-yyyy"
          //dateFormatter.timeZone = TimeZone(abbreviation: "IST")!
          return dateFormatter
      }

      //2020-10-09 02:07:37
      class func getTodaysDate() -> Date {
          var localTimeZoneAbbreviation: String { return  NSTimeZone.local.abbreviation(for: Date())! }
          return Date()
      }
    
      class func chatDateFormate() -> DateFormatter{
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MMM d, H:mm a"
          dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
          return dateFormatter
      }
    
//     class func serverFormate()->DateFormatter {
//          let dateFormatter = DateFormatter()
//          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//          dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
//          return dateFormatter
//      }
     
    func strToDate(strDate:String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let date = formatter.date(from: strDate)
        if date != nil{
            return date ?? Date()
        }else{
            return Date()
        }
    }
    
    class func serverFormateWithCP()->DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "IST")!
        return dateFormatter
    }
    
    func getCurrentDate() ->String{
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd MMM"
        let dateString = "Today, \(df.string(from: date))"
        return dateString
    }
 
}
