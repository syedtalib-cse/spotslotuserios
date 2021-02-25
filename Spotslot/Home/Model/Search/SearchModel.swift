

import Foundation
import ObjectMapper

struct SearchModel:Mappable {
	var vendors : [Vendors]?
	var portfolio : [VendorPortfolio]?

	init?(map: Map) {
	}

	mutating func mapping(map: Map) {
    	vendors <- map["vendors"]
		portfolio <- map["portfolio"]
	}

}
