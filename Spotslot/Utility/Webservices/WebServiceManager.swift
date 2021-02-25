//
//  WebServiceClass.swift
//  Link
//
//  Created by MINDIII on 10/3/17.
//  Copyright © 2017 MINDIII. All rights reserved.


import UIKit
import Alamofire
import KRProgressHUD

var AuthToken : String = ""

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

let objWebServiceManager = WebServiceManager.sharedObject()

class WebServiceManager: NSObject {
    
    //MARK: - Shared object
    fileprivate var window = UIApplication.shared.keyWindow
    
    private static var sharedNetworkManager: WebServiceManager = {
       // SVProgressHUD.setDefaultStyle(.light)
       // SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.9333333333, green: 0.9490196078, blue: 0.9960784314, alpha: 1))
       // SVProgressHUD.setDefaultMaskType(.clear)
       // SVProgressHUD.setMinimumDismissTimeInterval(1)
        //SVProgressHUD.setRingThickness(3)
        //SVProgressHUD.setRingRadius(22)
        let networkManager = WebServiceManager()
        return networkManager
    }()
    
    // MARK: - Accessors
    class func sharedObject() -> WebServiceManager {
        return sharedNetworkManager
    }
    
    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        print(configuration.timeoutIntervalForRequest)
         configuration.timeoutIntervalForRequest = 300
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    public func requestPostWithTokenInHeader(strURL:String, params : [String:Any],showHUD:Bool, showIndicator:Bool, success:@escaping(String) ->Void, failure:@escaping (Error) ->Void) {
        if !NetworkReachabilityManager()!.isReachable{
            self.showNetworkAlert()
            return
        }
        AuthToken = ""
        let url = BaseURL + strURL
        let headers = ["x-api-key" : "13!4#8%4&5(@R400t%33","token":AuthToken]
        print(url)
        print("ServiceURL = \(url)")
        print(url)
        print("Params = \(params)")
        print("AuthToken = \(AuthToken)")
        GlobalObj.displayLoader(showHUD, show: true)
        manager.retrier = OAuth2Handler()
        manager.request(url, method: .post, parameters: params, headers: headers).responseJSON { responseObject in
                    DispatchQueue.main.async {
                          GlobalObj.displayLoader(showHUD, show: false)
                        if responseObject.result.isSuccess {
                            do {
                                let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                // Session Expire
                                let dict = dictionary as! Dictionary<String, Any>
                                if dict["status"] as? String ?? "" == "success"{
                                    if let msg = dict["message"] as? String, msg == "Invalid Auth Token"{
                                        self.showAlertWithTitle(_title: "Alert", _message: "Session expires")
                                    }
                                }
                                print("Response = \(dictionary)")
                                let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
                                let decoded = String(data: jsonData, encoding: .utf8)!
                                /////
                                success(decoded)
                            }catch (let error){
                                print("Error in json serialization = \(error.localizedDescription)")
                            }
                        }
                        else if responseObject.result.isFailure {
                            let error : Error = responseObject.result.error!
        //                    print("Error = \(error)")
        //                    failure(error)
                            print("Error in json serialization = \(error.localizedDescription)")
                            let str = String(decoding: responseObject.data!, as: UTF8.self)
                            print("PHP error : \(str)")
                        }
                    }
        
            
        }
    }

    
    public func requestPost(strURL:String, params : [String:Any], showIndicator:Bool, success:@escaping(String) ->Void, failure:@escaping (Error) ->Void) {
        if !NetworkReachabilityManager()!.isReachable{
            self.showNetworkAlert()
            return
        }
        AuthToken = ""
        if SharedPreference.getUserData().token != nil{
            AuthToken = SharedPreference.getUserData().token!
        }
        let url = BaseURL + strURL
        let headers = ["token":AuthToken]
        print(url)
        print("ServiceURL = \(url)")
        print("url is ",url)
        print("Params = \(params)")
        print("AuthToken = \(AuthToken)")
        GlobalObj.displayLoader(showIndicator, show: true)
        manager.retrier = OAuth2Handler()
        manager.request(url, method: .post, parameters: params, headers: headers).responseJSON { responseObject in
                    DispatchQueue.main.async {
                         GlobalObj.displayLoader(showIndicator, show: false)
                        if responseObject.result.isSuccess {
                            do {
                                let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                // Session Expire
                                let dict = dictionary as! Dictionary<String, Any>
                                if dict["status"] as? String ?? "" == "success"{
                                    if let msg = dict["message"] as? String, msg == "Invalid Auth Token"{
                                        self.showAlertWithTitle(_title: "Alert", _message: "Session expires")
                                    }
                                }
                                print("Response = \(dictionary)")
                                let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
                                let decoded = String(data: jsonData, encoding: .utf8)!
                                /////
                                success(decoded)
                            }catch (let error){
                                print("Error in json serialization = \(error.localizedDescription)")
                            }
                        }
                        else if responseObject.result.isFailure {
                            let error : Error = responseObject.result.error!
        //                    print("Error = \(error)")
        //                    failure(error)
                            print("Error in json serialization = \(error.localizedDescription)")
                            let str = String(decoding: responseObject.data!, as: UTF8.self)
                            print("PHP error : \(str)")
                        }
                    }
        
            
        }
    }
    
    

    public func requestPostWithoutProgress(strURL:String, params : [String:Any], showIndicator:Bool, success:@escaping(String) ->Void, failure:@escaping (Error) ->Void) {
         if !NetworkReachabilityManager()!.isReachable{
                   self.showNetworkAlert()
                   return
               }
               AuthToken = ""
               if SharedPreference.getUserData().token != nil{
                   AuthToken = SharedPreference.getUserData().token!
               }
               let url = BaseURL + strURL
               let headers = ["token":AuthToken]
               print(url)
               print("ServiceURL = \(url)")
               print(url)
               print("Params = \(params)")
               print("AuthToken = \(AuthToken)")
               manager.retrier = OAuth2Handler()
               manager.request(url, method: .post, parameters: params, headers: headers).responseJSON { responseObject in
                           DispatchQueue.main.async {
                              //  GlobalObj.displayLoader(showIndicator, show: false)
                               if responseObject.result.isSuccess {
                                   do {
                                       let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                       // Session Expire
                                       let dict = dictionary as! Dictionary<String, Any>
                                       if dict["status"] as? String ?? "" == "success"{
                                           if let msg = dict["message"] as? String, msg == "Invalid Auth Token"{
                                               self.showAlertWithTitle(_title: "Alert", _message: "Session expires")
                                           }
                                       }
                                       print("Response = \(dictionary)")
                                       let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
                                       let decoded = String(data: jsonData, encoding: .utf8)!
                                       /////
                                       success(decoded)
                                   }catch (let error){
                                       print("Error in json serialization = \(error.localizedDescription)")
                                   }
                               }
                               else if responseObject.result.isFailure {
                                   let error : Error = responseObject.result.error!
                                   print("Error in json serialization = \(error.localizedDescription)")
                                   let str = String(decoding: responseObject.data!, as: UTF8.self)
                                   print("PHP error : \(str)")
                               }
                           }
               
                   
               }
      }
    
    
    
    
    
    
    public func requestGet(strURL:String, params : [String : AnyObject]?, showIndicator:Bool , success:@escaping(String) ->Void, failure:@escaping (Error) ->Void ) {
        if !NetworkReachabilityManager()!.isReachable{
            self.showNetworkAlert()
            return
        }
        AuthToken = ""
       if SharedPreference.getUserData().token != nil{
           AuthToken = SharedPreference.getUserData().token!
       }
        let headers: HTTPHeaders = [
            "token" : AuthToken
        ]
        let strURL = BaseURL+strURL
        var urlString = strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("url....\(strURL)")
        print("header....\(headers)")
        GlobalObj.displayLoader(showIndicator, show: true)
        Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { responseObject in
           GlobalObj.displayLoader(showIndicator, show: false)
            //self.StopIndicator()
            if responseObject.result.isSuccess {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // Session Expire
                    let dict = dictionary as! Dictionary<String, Any>
                    if dict["status"] as? String ?? "" == "success"{
                        if let msg = dict["message"] as? String, msg == "Invalid Auth Token"{
                            self.showAlertWithTitle(_title: "Alert", _message: "Session expires")
                        }
                    }
                    print("Response = \(dictionary)")
                    let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
                    let decoded = String(data: jsonData, encoding: .utf8)!
                    success(decoded)
                }catch{
                    let error : Error = responseObject.result.error!
                    failure(error)
                    let str = String(decoding: responseObject.data!, as: UTF8.self)
                    print("PHP ERROR : \(str)")
                }
            }
            if responseObject.result.isFailure {
                //self.StopIndicator()
                let error : Error = responseObject.result.error!
                failure(error)
                
                let str = String(decoding: responseObject.data!, as: UTF8.self)
                print("PHP ERROR : \(str)")
            }
        }
    }
    
    
    public func requestPostMultipartData(strURL:String, params : [String:Any],showIndicator:Bool, success:@escaping(String) ->Void, failure:@escaping (Error) ->Void ) {
        if !NetworkReachabilityManager()!.isReachable{
            self.showNetworkAlert()
            return
        }
        AuthToken = ""
//        if let token = UserDefaults.standard.string(forKey:UserDefaults.Keys.token){
//            AuthToken = token
//        }
        let strURL = BaseURL+strURL
        let url = strURL.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
        let headers = ["authToken" : AuthToken,
                       "Content-Type":"multipart/form-data",
                       "x-api-key" : "13!4#8%4&5(@R400t%33"]
        print("header is \(headers)")
       GlobalObj.displayLoader(showIndicator, show: true)
        manager.retrier = OAuth2Handler()
        manager.upload(multipartFormData:{ multipartFormData in
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }},
            usingThreshold:UInt64.init(),
            to:url,
            method:.post,
            headers:headers,
            encodingCompletion: { encodingResult in
               GlobalObj.displayLoader(showIndicator, show: false)
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { responseObject in
                        if responseObject.result.isSuccess {
                            do {
                                let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                // Session Expire
                                let dict = dictionary as! Dictionary<String, Any>
                                if dict["status"] as? String ?? "" == "success"{
                                    if let msg = dict["message"] as? String, msg == "Invalid Auth Token"{
                                        self.showAlertWithTitle(_title: "Alert", _message: "Session expires")
                                    }
                                }
                                print("Response = \(dictionary)")
                                let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
                                let decoded = String(data: jsonData, encoding: .utf8)!
                                success(decoded)
                            }catch{
                                let error : Error = responseObject.result.error!
                                failure(error)
                                let str = String(decoding: responseObject.data!, as: UTF8.self)
                                print("PHP ERROR : \(str)")
                            }
                        }
                        if responseObject.result.isFailure {
                            let error : Error = responseObject.result.error!
                            failure(error)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    failure(encodingError)
                }
        })
    }
    
    
    
    func callingAPIWithCustomHeader(username:String,password: String,url: String)  {
        let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)   // result of response serialization
        }
        
    }
 
    //MARK: - Convert String to Dict
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func isNetworkAvailable() -> Bool{
        if !NetworkReachabilityManager()!.isReachable{
            return false
        }else{
            return true
        }
    }
    
    func showNetworkAlert(){
        let alert = UIAlertController(title: "No network", message: "Please check your internet connection.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        //alert.show()
    }
    
    func showAlertWithTitle(_title: String, _message: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
       // alert.show()
    }
    
    
}

//MARK :- retrier

class OAuth2Handler : RequestRetrier {
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if error.localizedDescription.count > 0 && request.retryCount < 5{
            if error.localizedDescription == "The request timed out."{
                completion(false, 0.0) // don't retry
            }else{
                print("Retrying..\(String(describing: request.request?.url!)))")
                completion(true, 5.0)  // retry after 5 second
            }
        }else{
            completion(false, 0.0) // don't retry
        }
    }
}

extension WebServiceManager{
    public func uploadImage(strUrl:String,para:[String:Any],image:UIImage,imageName:String, showIndicator:Bool,succes:@escaping(_ response:String)->Void,Failler:@escaping(_ error:Error)->Void) {
        let completeURl = BaseURL+strUrl
        AuthToken = ""
        if SharedPreference.getUserData().token != nil{
            AuthToken = SharedPreference.getUserData().token!
        }
        let headers: HTTPHeaders = [
            "token" : AuthToken
        ]
         GlobalObj.displayLoader(showIndicator, show: true)
        print("header is \(headers)")
        print("url is \(completeURl)")

        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            if let imagedata = image.jpegData(compressionQuality: 0.5){
                let randomNum:UInt32 = arc4random_uniform(100) // range is 0 to 99
               let someInt:Int = Int(randomNum)
                MultipartFormData.append(imagedata, withName: imageName,fileName: "\(someInt)"+".png", mimeType: "image/png")
            }
            
            // import parameters
            for (key, value) in para {
                let stringValue = value as! String
                MultipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
            }
        }, usingThreshold:.max, to:completeURl, method: .post, headers: headers){ encodingResult in
        switch encodingResult {
        case .success(let upload, _, _):
            upload.responseJSON
                {
                    response in
                     GlobalObj.displayLoader(showIndicator, show: false)
                    switch response.result
                    {
                    case .success:
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with:response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                           
                            // Session Expire
                            let dict = dictionary as! Dictionary<String, Any>
                            if dict["status"] as? String ?? "" == "success"{
                                if let msg = dict["message"] as? String, msg == "Invalid Auth Token"{
                                    //self.showAlertWithTitle(_title: "Alert", _message: "Session expires")
                                }
                            }
                            print("Response = \(dictionary)")
                            let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
                            let decoded = String(data: jsonData, encoding: .utf8)!
                            succes(decoded)
                        }catch{
                            let error : Error = response.result.error!
                            let str = String(decoding: response.data!, as: UTF8.self)
                            print("PHP ERROR : \(str)")
                            Failler(error)
                        }
                    case .failure(let error):
                        let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                        print(responseString)
                        Failler(error)
                        //error(error as NSError)
                    }
            }
        case .failure(let encodingError):
            print(encodingError)
        }

           }
    }
  
}
