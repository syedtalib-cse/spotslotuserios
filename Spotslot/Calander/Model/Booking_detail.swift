

import Foundation
import ObjectMapper

struct Booking_detail : Mappable {
	var id : String?
	var order_number : String?
	var vendor_id : String?
	var user_id : String?
	var service_id : String?
	var service_type : String?
	var appointment_date : String?
	var primary_slot : String?
	var secondary_slot : String?
	var confirm_slot_id : String?
	var time_slot : String?
	var address : String?
	var duration : String?
	var travel_fee : String?
	var service_fee : String?
	var total_service_fee : String?
	var payment_method : String?
	var no_of_person : String?
	var booking_status : String?
	var note : String?
	var vendor_note : String?
	var created_at : String?
	var updated_at : String?
	var deleted_at : String?
	var service_detail : Service_detail?
    var vehicle_type : String?
    var travel_status : String?
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		order_number <- map["order_number"]
		vendor_id <- map["vendor_id"]
		user_id <- map["user_id"]
		service_id <- map["service_id"]
		service_type <- map["service_type"]
		appointment_date <- map["appointment_date"]
		primary_slot <- map["primary_slot"]
		secondary_slot <- map["secondary_slot"]
		confirm_slot_id <- map["confirm_slot_id"]
		time_slot <- map["time_slot"]
		address <- map["address"]
		duration <- map["duration"]
		travel_fee <- map["travel_fee"]
		service_fee <- map["service_fee"]
		total_service_fee <- map["total_service_fee"]
		payment_method <- map["payment_method"]
		no_of_person <- map["no_of_person"]
		booking_status <- map["booking_status"]
		note <- map["note"]
		vendor_note <- map["vendor_note"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		deleted_at <- map["deleted_at"]
		service_detail <- map["service_detail"]
        travel_status <- map["travel_status"]
        vehicle_type <- map["vehicle_type"]
	}

}
