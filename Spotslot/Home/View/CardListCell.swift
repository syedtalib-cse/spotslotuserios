//
//  CardListCell.swift
//  Spotslot
//
//  Created by Sunil Kumar on 27/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
//active
//293942
//FFFFFF

//not active
//232323

class CardListCell: UICollectionViewCell {
    
    @IBOutlet weak var imgClicked: UIImageView!
    @IBOutlet weak var lblCardHolderName: UILabel!
    @IBOutlet weak var lblCardType: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var imgCardType: UIImageView!
    @IBOutlet weak var lblCardCompany: UILabel!
    @IBOutlet weak var viewCard: UIView!
    
    //for bg active
    let bgActiveColor = #colorLiteral(red: 0.1607843137, green: 0.2235294118, blue: 0.2588235294, alpha: 1)
    
    //font color for not active
    let FontActiveColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
    
    var objCard:PaymentMethodList?{
        didSet{
            lblCardHolderName.text = objCard?.card_holder_name ?? ""
            lblCardType.text = objCard?.payment_method ?? ""
            lblCardNumber.text = "**** **** **** \((objCard?.card_number ?? "").suffix(4))"
            if  objCard?.isActive == "1"{
                imgClicked.image = UIImage(named:"selected-radio-button")
                bgCOlorWithFontColor(bgColor: bgActiveColor, fontColor:.white)
            }else{
               imgClicked.image = UIImage(named:"radio-button")
               bgCOlorWithFontColor(bgColor: .white, fontColor:FontActiveColor)
            }
        }
    }
    
    func bgCOlorWithFontColor(bgColor:UIColor,fontColor:UIColor){
        lblCardNumber.textColor = fontColor
        lblCardHolderName.textColor = fontColor
        lblCardType.textColor = fontColor
        lblCardCompany.textColor = fontColor
        viewCard.backgroundColor = bgColor
        
    }
    
}
