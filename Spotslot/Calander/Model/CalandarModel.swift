

import Foundation
import ObjectMapper

struct CalandarModel : Mappable {
	var upcomming : [Upcomming]?
	var previous : [Previous]?

	init?(map: Map) {
	}

	mutating func mapping(map: Map) {
		upcomming <- map["upcomming"]
		previous <- map["previous"]
	}

}
