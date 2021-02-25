

/*
 
 "id": "1",
 "slot": "08:30:00",
 "hours_format": "08:30 AM",
 "created_at": "2020-10-23 07:21:51",
 "updated_at": null,
 "deleted_at": null,
 "today_status": "available"
 
 
 */



import Foundation
import ObjectMapper

struct TimeSlotModel : Mappable {
	var id : String?
	var slot : String?
	var hours_format : String?
	var created_at : String?
	var updated_at : String?
	var deleted_at : String?
    var today_status : String?
    
	init?(map: Map) {
	}
	mutating func mapping(map: Map) {
        id <- map["id"]
		slot <- map["slot"]
		hours_format <- map["hours_format"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		deleted_at <- map["deleted_at"]
        today_status <- map["today_status"]
	}

}
