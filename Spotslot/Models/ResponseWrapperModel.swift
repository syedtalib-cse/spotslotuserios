//
//  ResponseWrapperModel.swift
//  Spotslot
//
//  Created by jaipee on 26/02/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import Foundation
import ObjectMapper

struct ResponseWrapperModel<T>: Mappable where T: Mappable {
    var status : Int?
    var message : String?
    var data: T?
    
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["object"]
    }
}

struct ResponseArrayWrapperModel<T>: Mappable where T: Mappable {
    var status : Int?
    var message : String?
    var data: [T]?
    
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["object"]
    }
}

struct EmptyMappableModel: Mappable {
    init?(map: Map) {}
    mutating func mapping(map: Map) {}
}
