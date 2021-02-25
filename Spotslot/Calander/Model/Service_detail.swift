
import Foundation
import ObjectMapper

struct Service_detail : Mappable {
	var id : String?
	var vendor_id : String?
	var service_name : String?
	var description : String?
	var category_id : String?
	var price : String?
	var service_charge : String?
	var durantion : String?
	var available_status : String?
	var created_at : String?
	var updated_at : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		vendor_id <- map["vendor_id"]
		service_name <- map["service_name"]
		description <- map["description"]
		category_id <- map["category_id"]
		price <- map["price"]
		service_charge <- map["service_charge"]
		durantion <- map["durantion"]
		available_status <- map["available_status"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
	}

}
