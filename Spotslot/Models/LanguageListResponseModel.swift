//
//  LanguageListResponseModel.swift
//  SplotslotVendor
//
//  Created by jaipee on 04/02/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: - LanguageListResponseModel
struct LanguageListResponseModel: Mappable {
    var languageList: [LanguageModel]?
    
    init(){
    }
    
    init?(map: Map) {
    }

    
    mutating func mapping(map: Map) {
        languageList <- map["language_list"]
    }
}
