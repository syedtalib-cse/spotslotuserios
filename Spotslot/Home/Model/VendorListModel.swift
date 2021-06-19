

import Foundation
import ObjectMapper

struct VendorlistModel: Mappable {
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
    var created_at : String?
    var updated_at : String?
    var profile_link : String?
    var vendor_avag_rating : Int?
    var portfolio : [Portfolio]?
    var isBookmark : Int?
    var specialize: String?
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        user_type <- map["user_type"]
        criminal_record_status <- map["criminal_record_status"]
        plan_id <- map["plan_id"]
        language_id <- map["language_id"]
        name <- map["name"]
        user_name <- map["user_name"]
        gender <- map["gender"]
        email <- map["email"]
        forgot_password_code <- map["forgot_password_code"]
        password <- map["password"]
        actual_password <- map["actual_password"]
        dob <- map["dob"]
        address <- map["address"]
        bio <- map["bio"]
        profile_image <- map["profile_image"]
        background_img <- map["background_img"]
        referal_code <- map["referal_code"]
        mobile_number <- map["mobile_number"]
        allergies <- map["allergies"]
        haircut_freuency <- map["haircut_freuency"]
        status <- map["status"]
        is_available <- map["is_available"]
        is_profile_verify <- map["is_profile_verify"]
        tier_level <- map["tier_level"]
        device_type <- map["device_type"]
        device_id <- map["device_id"]
        token <- map["token"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        profile_link <- map["profile_link"]
        vendor_avag_rating <- map["vendor_avag_rating"]
        portfolio <- map["portfolio"]
        isBookmark <- map["isBookmark"]
        specialize <- map["specialize"]
    }

}


struct Portfolio : Mappable {
    var id : String?
    var vendor_id : String?
    var image : String?
    var description : String?
    var status : String?
    var created_at : String?
    var update_at : String?
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        vendor_id <- map["vendor_id"]
        image <- map["image"]
        description <- map["description"]
        status <- map["status"]
        created_at <- map["created_at"]
        update_at <- map["update_at"]
    }

}


class AddressModel:NSObject{
    var address:String = ""
    var city:String = ""
    var state:String = ""
    var country:String = ""
    var zipCode:String = ""
    var lat :String = ""
    var lng :String = ""
    
    override init(){
        self.address = ""
        self.city = ""
        self.state = ""
        self.country = ""
        self.lat = ""
        self.lng = ""
    }
}
