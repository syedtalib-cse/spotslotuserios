

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



struct TimeSlotModel: Mappable {
    
    var message: String?
    var object: TimeObject?
    var status: Int?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    message <- map["message"]
    object <- map["object"]
    status <- map["status"]
    }
    
}



struct TimeObject: Mappable {
    
    var customerdefaulttimeslot: [AnyObject]?
    var usertime: [TimeUsertime]?
    var vendordefaulttimeslot: [Vendordefaulttimeslot]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    customerdefaulttimeslot <- map["customerdefaulttimeslot"]
    usertime <- map["usertime"]
    vendordefaulttimeslot <- map["vendordefaulttimeslot"]
    }
    
}
struct Vendordefaulttimeslot: Mappable {
    
    var id: Int?
    var timeslot: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    id <- map["id"]
    timeslot <- map["timeslot"]
    }
    
}

struct TimeUsertime: Mappable {
    
    var createdAt: String?
    var deletedAt: AnyObject?
    var hoursFormat: String?
    var id: String?
    var slot: String?
    var todayStatus: String?
    var updatedAt: AnyObject?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    createdAt <- map["created_at"]
    deletedAt <- map["deleted_at"]
    hoursFormat <- map["hours_format"]
    id <- map["id"]
    slot <- map["slot"]
    todayStatus <- map["today_status"]
    updatedAt <- map["updated_at"]
    }
    
}




