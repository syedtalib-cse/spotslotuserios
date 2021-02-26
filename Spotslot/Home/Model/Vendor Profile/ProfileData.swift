

import Foundation
import ObjectMapper

struct ProfileData : Mappable {
	var about : About?
	var services : [Services]?
	var portfolio : [VendorPortfolio]?
    var setcoverage: CoverageDetail?
    var buisness_hours: BuisnessHourDetail?
    var languages: [LanguageModel]?

	init?(map: Map) {	}

	mutating func mapping(map: Map) {
     	about <- map["about"]
		services <- map["services"]
		portfolio <- map["portfolio"]
        setcoverage <- map["setcoverage"]
        buisness_hours <- map["buisness_hours"]
        languages <- map["language_know"]
	}

    
}








