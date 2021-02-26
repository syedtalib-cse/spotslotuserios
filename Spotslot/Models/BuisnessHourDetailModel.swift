//
//  File.swift
//  Spotslot
//
//  Created by jaipee on 26/02/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - BuisnessHourDetail
struct BuisnessHourDetail: Mappable {
    var id: String?
    var monFri: String?
    var sat: String?
    var sun: String?
    var advanceNotice: String?
    //var reOccuringAgenda: [AgendaListModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        monFri <- map["mon_fri"]
        sat <- map["sat"]
        sun <- map["sun"]
        advanceNotice <- map["advance_notice"]
        //reOccuringAgenda <- map["re_occuring_agenda"]
    }
}
