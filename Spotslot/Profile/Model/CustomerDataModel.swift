
import Foundation
import ObjectMapper

struct CustomerDataModel : Mappable {
	var customer_id : String?
	var name : String?
	var email : String?
	var allergies : String?
	var haircut_freuency : String?
	var password : String?
	var gender : String?
	var dob : String?
	var language_know : String?
    var profile_image:String?
    var notification_status : String?
    var favorite_styles : [Favorite_styles]?
    
	init?(map: Map) {
	}

	mutating func mapping(map: Map) {
    	customer_id <- map["customer_id"]
		name <- map["name"]
		email <- map["email"]
		allergies <- map["allergies"]
		haircut_freuency <- map["haircut_freuency"]
		password <- map["password"]
		gender <- map["gender"]
		dob <- map["dob"]
		language_know <- map["language_know"]
        profile_image <- map["profile_image"]
        favorite_styles <- map["favorite_styles"]
        notification_status <- map["notification_status"]
	}

}
