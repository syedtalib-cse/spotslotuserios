

import Foundation
import ObjectMapper

struct Bookmark_vendor : Mappable {
	var profile_image : String?
	var name : String?
	var user_name : String?
	var vendor_id : String?
	var user_id : String?
	var mark_type : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		profile_image <- map["profile_image"]
		name <- map["name"]
		user_name <- map["user_name"]
		vendor_id <- map["vendor_id"]
		user_id <- map["user_id"]
		mark_type <- map["mark_type"]
	}

}
