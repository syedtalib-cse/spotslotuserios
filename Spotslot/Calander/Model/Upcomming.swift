

import Foundation
import ObjectMapper

struct Upcomming : Mappable {
	var id : String?
	var appointment_date : String?
	var booking_status : String?
	var primary_slot : String?
	var secondary_slot : String?
	var vendor_id : String?
	var service_id : String?
	var service_type : String?
	var vendor_image : String?
	var vendor_name : String?
	var username : String?
	var avag_rating : Int?
	var booking_detail : Booking_detail?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		appointment_date <- map["appointment_date"]
		booking_status <- map["booking_status"]
		primary_slot <- map["primary_slot"]
		secondary_slot <- map["secondary_slot"]
		vendor_id <- map["vendor_id"]
		service_id <- map["service_id"]
		service_type <- map["service_type"]
		vendor_image <- map["vendor_image"]
		vendor_name <- map["vendor_name"]
        print("Vendor name \(vendor_name)")
		username <- map["username"]
		avag_rating <- map["avag_rating"]
		booking_detail <- map["booking_detail"]
	}

}
