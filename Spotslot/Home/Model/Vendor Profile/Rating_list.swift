

import Foundation
import ObjectMapper

struct Rating_list : Mappable {
	var name : String?
	var profile_image : String?
	var id : String?
	var user_id : String?
	var vendor_id : String?
	var rating : String?
	var review : String?
	var created_at : String?
	var updated_at : String?
	var deleted_at : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		name <- map["name"]
		profile_image <- map["profile_image"]
		id <- map["id"]
		user_id <- map["user_id"]
		vendor_id <- map["vendor_id"]
		rating <- map["rating"]
		review <- map["review"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		deleted_at <- map["deleted_at"]
	}

}
