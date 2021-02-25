

import Foundation
import ObjectMapper

struct Services : Mappable {
    var id : String?
    var category_name : String?
    var service_list : [Service_list]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        category_name <- map["category_name"]
        service_list <- map["service_list"]
    }

}
