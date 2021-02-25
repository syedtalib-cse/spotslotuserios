//
//  LanguageListModel.swift
//  Spotslot
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import Foundation
class LanguageListModel {
    var name:String?
    var imageName:String?
    
    static let modelobj = LanguageListModel()
    
    init(){
    }
    init(name:String,imageName:String) {
        self.name = name
        self.imageName = imageName
    }
    
    
    func setArray() -> [LanguageListModel] {
        var arrModel = [LanguageListModel]()
        let obj1 = LanguageListModel(name: "English (UK)", imageName: "English")
        arrModel.append(obj1)
        let obj2 = LanguageListModel(name: "English (US)", imageName: "English(US)")
        arrModel.append(obj2)
        let obj3 = LanguageListModel(name: "French", imageName: "French")
        arrModel.append(obj3)
        let obj4 = LanguageListModel(name: "Spanish", imageName: "Spanish")
        arrModel.append(obj4)
        return arrModel
    }
}
