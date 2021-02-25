

import Foundation
import ObjectMapper

struct ProfileData : Mappable {
	var about : About?
	var services : [Services]?
	var portfolio : [VendorPortfolio]?

	init?(map: Map) {	}

	mutating func mapping(map: Map) {
     	about <- map["about"]
		services <- map["services"]
		portfolio <- map["portfolio"]
	}

    
}
