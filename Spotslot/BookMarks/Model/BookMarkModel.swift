

import Foundation
import ObjectMapper

struct BookMarkModel : Mappable {
	var favorite : [Favorite]?
	var bookmark_vendor : [VendorlistModel]?
	var all : [All]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		favorite <- map["favorite"]
		bookmark_vendor <- map["bookmark_vendor"]
		all <- map["all"]
	}

}
