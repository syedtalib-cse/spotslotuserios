//
//  ServiceResponseModel.swift
//  Spotslot
//
//  Created by MacBook on 20/07/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import Foundation
import ObjectMapper
struct ServiceBookResponseModel: Mappable {
    
    var message: String?
    var serviceBookObject: ServiceBookObject?
    var status: Int?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        serviceBookObject <- map["object"]
        status <- map["status"]
    }
    
}
struct ServiceBookObject: Mappable {
    init?(map: Map) { }
    mutating func mapping(map: Map) {
    }
    
}

