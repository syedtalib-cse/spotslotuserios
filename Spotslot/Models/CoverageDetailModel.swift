//
//  File.swift
//  Spotslot
//
//  Created by jaipee on 26/02/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: - CoverageDetail
struct CoverageDetail: Mappable {
    var id: String?
    var vendorID: String?
    var radius: String?
    var latitude: String?
    var longitude: String?
    var address: String?
    var createdAt: String?
    var updatedAt: String?
    //var coverageCountryDetails: [CoverageCountryDetail]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        vendorID <- map["vendor_id"]
        radius <- map["radius"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        address <- map["address"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        //coverageCountryDetails <- map["coverage_country_details"]
    }
}
