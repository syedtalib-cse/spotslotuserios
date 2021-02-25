

import Foundation
import ObjectMapper

/*
 "name": "Abhsihek",
  "user_name": "Abhi@123",
 
 */
struct VendorPortfolio : Mappable {
	var id : String?
	var vendor_id : String?
	var image : String?
	var description : String?
	var status : String?
	var created_at : String?
	var update_at : String?
    var profile_image:String?
    
    var name:String?
    var user_name:String?

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
        profile_image <- map["profile_image"]
        name <- map["name"]
         user_name <- map["user_name"]
        }
}
