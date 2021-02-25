//
//  AppDelegate.swift
//  Spotslot
//
//  Created by mac on 18/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import CoreData
import REFrostedViewController
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import Stripe
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let googleApiKey = "AIzaSyAEAARDc1sUyiAJ8C8ti8Wa--_Yr6scZw8"//"AIzaSyBrFFL9c6R-OEXf0IU4WG59GfrCwLxlY1E"
    let stripeApiKey = "pk_test_JyEYiyZ8htIt2bqOn2KB5mOm00hiD1tOhh"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        IQKeyboardManager.shared.enable = true
        Stripe.setDefaultPublishableKey(stripeApiKey)
        GMSServices.provideAPIKey(self.googleApiKey)//Google Map
        GMSPlacesClient.provideAPIKey(self.googleApiKey) //Google Place
        FirebaseApp.configure()
        self.registerForRemoteNotification()
        
        DispatchQueue.main.async {
            Thread.sleep(forTimeInterval: 4.0)
            UIApplication.shared.windows.forEach { window in
                if #available(iOS 13.0, *) {
                    window.overrideUserInterfaceStyle = .light
                } else {
                    // Fallback on earlier versions
                }
            }
        }

        GlobalObj.manageNavigationForAlreadyLoggedIn()
      //  SetDashBoardDorVender()
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Spotslot")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    /*func SetDashBoardDorVender()  {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "rootController") as! REFrostedViewController //root
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationController")
        let sideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController")
        rootVC.contentViewController = navigationController
        rootVC.menuViewController =  sideMenuVC
        self.window?.rootViewController = rootVC
    }*/
}


//for push notification
extension AppDelegate : MessagingDelegate,UNUserNotificationCenterDelegate{
    func registerForRemoteNotification() {
        // iOS 10 support
        if #available(iOS 10, *) {
            let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options:authOptions){ (granted, error) in
                
                // For iOS 10 display notification (sent via APNS)
                UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
                // For iOS 10 data message (sent via FCM)
                Messaging.messaging().delegate = self
                
                
                DispatchQueue.main.async {
                  UIApplication.shared.registerForRemoteNotifications()
                }
                NotificationCenter.default.addObserver(self, selector:
                    #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
            }
        }else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
         InstanceID.instanceID().instanceID { (result, error) in
         if let error = error {
         print("Error fetching remote instange ID: \(error)")
         } else if let result = result {
         print("Remote instance ID token: \(result.token)")
           // objAppShareData.kFCMToken = result.token
          }
         }
            
    }
    
    // MARK: - FCM Token
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("FCM registration token: \(fcmToken)")
        //objAppShareData.kFCMToken = fcmToken
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
       // objAppShareData.kFCMToken = fcmToken
    }
    
    //MARK: Notification
    @objc func tokenRefreshNotification(_ notification: Notification) {
//        if let refreshedToken = InstanceID.instanceID().token() {
//            print("InstanceID token: \(refreshedToken)")
//            objAppShareData.kFCMToken = refreshedToken
//        }
        InstanceID.instanceID().instanceID { (result, error) in
        if let error = error {
        print("Error fetching remote instange ID: \(error)")
        } else if let result = result {
        print("Remote instance ID token: \(result.token)")
           // objAppShareData.kFCMToken = result.token
         }
        }
        
    }
    /*// Receive data message on iOS 10 devices while app is in the foreground.
    @objc(applicationReceivedRemoteMessage:)
    func application(received remoteMessage: MessagingRemoteMessage) {
        print("applicationReceivedRemoteMessage = %@", remoteMessage.appData)
    }*/
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo as? [String : Any] ?? [:]
       // self.handleNotificationWith(userInfo: userInfo)
        print("willPresent notification = \(userInfo)")
        completionHandler([.alert,.sound,.badge])
    }
    
    //called When you tap on the notification
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo as? [String : Any] ?? [:]
        print("didReceive notification = \(userInfo)")
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.handleNotificationWith(userInfo: userInfo)
    }
    
    func handleNotificationWith(userInfo:[AnyHashable : Any]){
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
//        notificationType = userInfo["type"] as? String ?? ""
//        notify_Id = userInfo["order_id"] as? String ?? ""
    }
}
