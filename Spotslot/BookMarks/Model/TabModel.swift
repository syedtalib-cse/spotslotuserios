//
//  TabModel.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import Foundation
struct TabModel {
    var isSelectedTab :Bool
    var title:String
    init(isSelectedTab:Bool, title:String) {
        self.isSelectedTab = isSelectedTab
        self.title = title
    }
}
