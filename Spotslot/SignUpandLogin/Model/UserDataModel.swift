
import Foundation
import ObjectMapper
import KRProgressHUD


struct NotificationModel : Mappable {
    var notification_status : String?
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        notification_status <- map["notification_status"]
    }
}


struct UserDataModel : Mappable {
    
    var status : Int?
    var message : String?
    var object : UserData?
    var VendorlistObject : [VendorlistModel]?
    var VendorProfile:ProfileData?
    var arrofSpecilization:[SpecializationModel]?
    var arrOfTimeSlot:[TimeSlotModel]?
    var arrOfAddressObj:[AddressListModel]?
    var objCustomerData:CustomerDataModel?
    var objPaymentMethodList:[PaymentMethodList]?
    var objNotifictaion:NotificationModel?
    var objCalandarModel:CalandarModel?
    var objBookMarkModel: BookMarkModel?
    var searchModelObj:SearchModel?
    var arrOfChatModel:[ChatModel]?
    var objPaymentModel:PaymentModel?
    
    
    init?(map: Map) {
    }
    
    init() {
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        object <- map["object"]
        VendorlistObject <- map["object"]
        VendorProfile <- map["object"]
        arrofSpecilization <- map["object"]
        arrOfTimeSlot <- map["object"]
        arrOfAddressObj <- map["Output"]
        objCustomerData <- map["object"]
        objPaymentMethodList <- map["object"]
        objNotifictaion <- map["object"]
        objCalandarModel <- map["object"]
        objBookMarkModel <- map["object"]
        searchModelObj <- map["object"]
        arrOfChatModel <- map["object"]
        objPaymentModel <- map["object"]
    }
    
    //to login
    static func webServicesToSignIn(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:loginUrl, params: params, showIndicator: true, success: { (response) in
            print("response is \(response)")
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            SharedPreference.saveUserData(user: responseModel?.object ?? UserData())
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //to Sign Up
    static func webServicesToSignUp(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
        //SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:signUnUrl, params: params, showIndicator: true, success: { (response) in
            print("response is \(response)")
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            SharedPreference.saveUserData(user: responseModel?.object ?? UserData())
            completion(responseModel)
        }) { (error) in
          //  SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To forgot password
    static func webServicesToForgotPassword(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:forgetPassword, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
       //     SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To verify the otp while forgoting password
    static func webServicesToverifyOtp(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:checkCode, params:params, showIndicator: true, success: { (response) in
            print(response)
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
         //   SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //to reset password
    static func webServicesToResetPassword(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:resetPassword, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //to get Vendor list
    static func webServicesToGetVendorList(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:getVendors, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
          //  SVProgressHUD.dismiss()//
            print(error)
        }
    }
    
    //to get Vendor list
      static func webServicesToGetVendorProfiledata(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
     //     SVProgressHUD.show()
          print(params)
          objWebServiceManager.requestPost(strURL:vendorProfile, params:params, showIndicator: true, success: { (response) in
              let responseModel = Mapper<UserDataModel>().map(JSONString: response)
              completion(responseModel)
          }) { (error) in
             // SVProgressHUD.dismiss()
              print(error)
          }
      }
    
    //To update location in every 10 seconds
    static func webServicesToUpdateLocation(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPostWithoutProgress(strURL:updateLocation, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
            //SVProgressHUD.dismiss()
            print(error)
        }
    }
    
       //To filter data
       static func webServicesToFilter(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
          // SVProgressHUD.show()
           print(params)
           objWebServiceManager.requestPost(strURL:filterVendor, params:params, showIndicator: true, success: { (response) in
               let responseModel = Mapper<UserDataModel>().map(JSONString: response)
               completion(responseModel)
           }) { (error) in
               //SVProgressHUD.dismiss()
               print(error)
           }
       }
    

    //to get all services list
      static func webServicesTogetVendorSpecialization(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
         // SVProgressHUD.show()
          print(params)
          objWebServiceManager.requestGet(strURL:vendorSpecialization, params:params as [String : AnyObject], showIndicator: true, success: { (response) in
              let responseModel = Mapper<UserDataModel>().map(JSONString: response)
              completion(responseModel)
          }) { (error) in
             // SVProgressHUD.dismiss()
              print(error)
          }
      }
    
    //To get timeSlot data vendorId
    static func webServicesTogetTimeSlotData(params:[String:Any],completion:@escaping(TimeSlot?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:defualtTimeSlot, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<TimeSlot>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
          //  SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To book the services
    static func webServicesToBookServices(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:bookService, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
           // SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To get timeSlot data
    static func webServicesTogetMyAddress(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestGet(strURL:myAddress, params:[:], showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
           // SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To Add My address
    static func webServiceToAddMyAddress(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
         // SVProgressHUD.show()
          print(params)
          objWebServiceManager.requestPost(strURL:addAddress, params:params, showIndicator: true, success: { (response) in
              let responseModel = Mapper<UserDataModel>().map(JSONString: response)
              completion(responseModel)
          }) { (error) in
         //     SVProgressHUD.dismiss()
              print(error)
          }
      }
    
    //To delete My address
    static func webServiceToDeleteMyAddress(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:deleteAddress, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
         //   SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    
    //To edit My address
    static func webServiceToEditMyAddress(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:editAddress, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    
    //To make main My address
       static func webServiceToMakeMainAddress(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
        //   SVProgressHUD.show()
           print(params)
           objWebServiceManager.requestPost(strURL:makeMainAddress, params:params, showIndicator: true, success: { (response) in
               let responseModel = Mapper<UserDataModel>().map(JSONString: response)
               completion(responseModel)
           }) { (error) in
         //      SVProgressHUD.dismiss()
               print(error)
           }
       }
    
    //T/o make main My address
    static func webServicesToChanegThePassword(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:changePassword, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
         //   SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To get customer data
    static func webServicesToGetCustomerData(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestGet(strURL:getProfile, params:[:], showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To add language by customer
    static func webServicesToAddLanguage(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:addEditLanguage, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    static func webserviceTogetAllLanguages(params:[String:Any],completion:@escaping(ResponseWrapperModel<LanguageListResponseModel>?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestGet(strURL:getAllLanguages, params: [:], showIndicator: true, success: { (response) in
            let responseModel = Mapper<ResponseWrapperModel<LanguageListResponseModel>>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
          //  SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To add language to thier profile
    static func webServicesToAddlanguage(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:addLanguage, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
          //  SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To Uodate profile by the customer
     static func WebserviceCallingtoUploadProfilePic(imagePara:UIImage,imageName:String,params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       //  SVProgressHUD.show()
         objWebServiceManager.uploadImage(strUrl:updateProfile, para: params, image: imagePara, imageName: imageName, showIndicator: true, succes: { (response) in
             let responseModel = Mapper<UserDataModel>().map(JSONString: response)
             completion(responseModel)
        //     SVProgressHUD.dismiss()
         }) { (error) in
             print("error is \(error)")
         }
     }
   
    //To add Card by the customer
   static func webServicesToAddPaymentMethod(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
     //   SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:addPaymentMethod, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To get payment Method data of teh customer
    static func webServiceToGetAllPaymentList(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestGet(strURL:getPaymentMethod, params:[:], showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
          //  SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To delete Card by the customer
    static func webServicesToDeletePaymentMethod(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:deletePaymentMethod, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
      //      SVProgressHUD.dismiss()
            print(error)
        }
     }
    
    //To delete Card by the customer
    static func webServicesToEditPaymentMethod(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
     //   SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:editPaymentMethod, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
      //      SVProgressHUD.dismiss()
            print(error)
        }
     }
    
    //To delete Card by the customer
      static func webServicesToOnOFNotification(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //    SVProgressHUD.show()
          print(params)
          objWebServiceManager.requestPost(strURL:notificationOnOff, params:params, showIndicator: true, success: { (response) in
              let responseModel = Mapper<UserDataModel>().map(JSONString: response)
              completion(responseModel)
          }) { (error) in
         //     SVProgressHUD.dismiss()
              print(error)
          }
       }
    
    
    //To get all appointment list
    static func webServiceToGetAllAppointmentList(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestGet(strURL:calendar, params:[:], showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    
    //To get all booked marked list
    static func webServiceToGetAllBookedList(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestGet(strURL:getStyles, params:[:], showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
      
    //To do book marked
    static func webServiceToBookMarkToVendor(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:bookmarkVendor, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
        //    SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To give the rate to the vendor
       static func webServiceToRateToVendor(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
        //   SVProgressHUD.show()
           print(params)
           objWebServiceManager.requestPost(strURL:ratingReview, params:params, showIndicator: true, success: { (response) in
               let responseModel = Mapper<UserDataModel>().map(JSONString: response)
               completion(responseModel)
           }) { (error) in
            //   SVProgressHUD.dismiss()
               print(error)
           }
       }
       
    
    //To give the rate to the vendor
    static func webServiceToMakeDefaultPayment(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
       // SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPost(strURL:setDefualtPaymentMethod, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
    //        SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    
    //To search with keyword
    static func webServiceSearchWithKeyword(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPostWithoutProgress(strURL:search, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
            //SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    //To Like Dislike Portfolios
    static func webServiceLikeDislikePortfolios(params:[String:Any],completion:@escaping(ResponseWrapperModel<LikeDislikePortfolioResponse>?) -> Void){
      //  SVProgressHUD.show()
        print(params)
        objWebServiceManager.requestPostWithoutProgress(strURL:favoriteUnfavoriteStyle, params:params, showIndicator: true, success: { (response) in
            let responseModel = Mapper<ResponseWrapperModel<LikeDislikePortfolioResponse>>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
            //SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    

    //To get all booked marked list
       static func webServiceToLogOut(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
           print(params)
           objWebServiceManager.requestGet(strURL:logout, params:[:], showIndicator: true, success: { (response) in
               let responseModel = Mapper<UserDataModel>().map(JSONString: response)
               completion(responseModel)
           }) { (error) in
               print(error)
           }
       }
    
       //To Cancel the appointments
       static func webServiceToCancelAPpoint(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
           print(params)
           objWebServiceManager.requestPost(strURL:cancelRequest, params:params, showIndicator: true, success: { (response) in
               let responseModel = Mapper<UserDataModel>().map(JSONString: response)
               completion(responseModel)
           }) { (error) in
               print(error)
           }
       }
    
    //To delete offer and loyalty
      static func webServiceToGetAllMessage(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
          print(params)
          objWebServiceManager.requestPost(strURL:chatHistory, params:params,showIndicator: true, success: { (response) in
              let responseModel = Mapper<UserDataModel>().map(JSONString: response)
              completion(responseModel)
          }) { (error) in
              print(error)
          }
      }
    
    
    //To delete offer and loyalty
    static func weberviceToSendMessage(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
        print(params)
        objWebServiceManager.requestPostWithoutProgress(strURL:sendMessage, params:params,showIndicator: true, success: { (response) in
            let responseModel = Mapper<UserDataModel>().map(JSONString: response)
            completion(responseModel)
        }) { (error) in
            print(error)
        }
    }
   
    //To delete offer and loyalty
       static func weberviceToMakePayment(params:[String:Any],completion:@escaping(UserDataModel?) -> Void){
           print(params)
           objWebServiceManager.requestPost(strURL:pay, params:params,showIndicator: true, success: { (response) in
               let responseModel = Mapper<UserDataModel>().map(JSONString: response)
               completion(responseModel)
           }) { (error) in
               print(error)
           }
       }
      
    
    
    
}

