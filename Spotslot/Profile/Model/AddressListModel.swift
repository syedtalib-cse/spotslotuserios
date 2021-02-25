

import Foundation
import ObjectMapper

struct AddressListModel : Mappable {
    var user_address_id : String?
    var address_name : String?
    var location : String?
    var main_address_status : String?
    var user_latitude:String?
    var user_logitude:String?
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        user_address_id <- map["user_address_id"]
        address_name <- map["address_name"]
        location <- map["location"]
        main_address_status <- map["main_address_status"]
        user_logitude <- map["user_logitude"]
        user_latitude <- map["user_latitude"]
    }
    
}
