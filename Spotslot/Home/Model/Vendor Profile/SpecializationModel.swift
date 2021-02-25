

import Foundation
import ObjectMapper

struct SpecializationModel : Mappable {
    
	var id : String?
	var name : String?
	var status : String?
	var created_at : String?
	var updated_at : String?
    var isSelected:Bool?

	init?(map: Map) {
	}
    
	mutating func mapping(map: Map) {
		id <- map["id"]
		name <- map["name"]
		status <- map["status"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
        isSelected = false
	}

}
