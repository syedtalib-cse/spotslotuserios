//
//  SharedPreference.swift
//  Speed Shopper
//
//  Created by info on 14/04/18.
//  Copyright © 2018 mac. All rights reserved.
//


/*
 var id : String?
 var user_type : String?
 var criminal_record_status : String?
 var plan_id : String?
 var language_id : String?
 var name : String?
 var user_name : String?
 var gender : String?
 var email : String?
 var forgot_password_code : String?
 var password : String?
 var actual_password : String?
 var dob : String?
 var address : String?
 var bio : String?
 var profile_image : String?
 var background_img : String?
 var referal_code : String?
 var mobile_number : String?
 var allergies : String?
 var haircut_freuency : String?
 var status : String?
 var is_available : String?
 var is_profile_verify : String?
 var tier_level : String?
 var device_type : String?
 var device_id : String?
 var token : String?
 var latitude : String?
 var longitude : String?
 var allergies_important : String?
 var cut_hair_session : String?
 var created_at : String?
 var updated_at : String?
 */


import Foundation
import ObjectMapper


class SharedPreference: NSObject {
 
    fileprivate let kCustomer_id = "customer_id"
    fileprivate let kPlan_id = "plan_id"
    fileprivate let kname = "name"
    fileprivate let kemail = "email"
    fileprivate let ktoken = "token"
    fileprivate let kdevice_id = "device_id"
    fileprivate let kdevice_type = "device_type"
    fileprivate let address = "address"
    fileprivate let background_img = "background_img"
    fileprivate let bio = "bio"
    fileprivate let criminal_record_status = "bio"
    fileprivate let dob = "dob"
    fileprivate let gender = "gender"
    fileprivate let language_know = "language_know"
    fileprivate let profile_img = "profile_img"
    
    fileprivate let defaults = UserDefaults.standard
    static let sharedInstance = SharedPreference()
    
    class func saveUserData(user:UserData){
        sharedInstance.saveUserData(user)
    }
    
    fileprivate func saveUserData(_ user: UserData){
        defaults.setValue(user.id , forKey:kCustomer_id )
        defaults.setValue(user.email, forKey: kemail)
        defaults.setValue(user.name, forKey: kname)
        defaults.setValue(user.email, forKey: kemail)
        defaults.setValue(user.token, forKey: ktoken)
        defaults.setValue(user.device_id, forKey: kdevice_id)
        defaults.setValue(user.device_type, forKey: kdevice_type)
       //defaults.setValue(user.address, forKey: address)
       // defaults.setValue(user.background_img, forKey: background_img)
       // defaults.setValue(user.bio, forKey: bio)
       defaults.setValue(user.profile_image, forKey: profile_img)
       // defaults.setValue(user.language_know, forKey: language_know)
        defaults.setValue(user.gender, forKey: gender)
       // defaults.setValue(user.criminal_record_status, forKey: criminal_record_status)
        defaults.synchronize()
    }
    
    class func clearUserData(){
      sharedInstance.clearUserData()
    }
    
    fileprivate func clearUserData(){
     self.deleteUserData()
    }
    
    fileprivate func deleteUserData(){
        defaults.removeObject(forKey: kCustomer_id)
        defaults.removeObject(forKey: kemail)
        defaults.removeObject(forKey: kPlan_id)
        defaults.removeObject(forKey: kemail)
        defaults.removeObject(forKey: kname)
        defaults.removeObject(forKey: ktoken)
        defaults.removeObject(forKey: kdevice_id)
        defaults.removeObject(forKey: kdevice_type)
        defaults.synchronize()
    }
    
    class func getUserData() -> UserData{
        return sharedInstance.getUserData()
    }
    
    fileprivate  func getUserData() -> UserData {
        var user:UserData  = UserData()
        user.token         = defaults.value(forKey: ktoken) as? String
        user.name         = defaults.value(forKey: kname) as? String
       // user.plan_id          = defaults.value(forKey: kPlan_id) as? String
        user.email        = defaults.value(forKey: kemail) as? String
        user.id          = defaults.value(forKey: kCustomer_id) as? String
        user.device_id        = defaults.value(forKey: kdevice_id) as? String
        user.device_type          = defaults.value(forKey: kdevice_type) as? String
       // user.address          = defaults.value(forKey: address) as? String
         user.profile_image          = defaults.value(forKey: profile_img) as? String
       // user.language_know          = defaults.value(forKey: language_know) as? String
        user.gender          = defaults.value(forKey: gender) as? String
       // user.criminal_record_status          = defaults.value(forKey: criminal_record_status) as? String
        //user.background_img          = defaults.value(forKey:background_img) as? String
        return user
    }
    
    class func storeDeviceToken(_ token: String) {
        sharedInstance.setDeviceToken(token)
    }
    
    class func deviceToken() -> String {
        return sharedInstance.getDeviceToken() ?? "1234567890"
    }
    
    fileprivate func setDeviceToken(_ token: String){
        defaults.set(token, forKey: ktoken);
    }
    
    fileprivate func getDeviceToken() -> String?{
        return defaults.value(forKey: ktoken) as? String;
    }
    
    
}
