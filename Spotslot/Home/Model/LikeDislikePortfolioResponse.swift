//
//  File.swift
//  Spotslot
//
//  Created by jaipee on 26/02/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import Foundation
import ObjectMapper

struct LikeDislikePortfolioResponse: Mappable {
    var vendorID: String?
    var userID: String?
    var portfolioID: String?

    init() {}

    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
        vendorID <- map["vendor_id"]
        userID <- map["user_id"]
        portfolioID <- map["portfolio_id"]
    }

}

