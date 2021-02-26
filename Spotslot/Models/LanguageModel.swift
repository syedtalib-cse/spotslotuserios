//
//  File.swift
//  Spotslot
//
//  Created by jaipee on 26/02/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - LanguageModel
struct LanguageModel: Mappable {
    var id: String?
    var languageName: String?
    var selected: Bool = false
    init(){
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        languageName <- map["language_name"]
    }
}


extension LanguageModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
