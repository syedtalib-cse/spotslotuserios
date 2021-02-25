//
//  TabCoolectionCell.swift
//  Spotslot
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class TabCoolectionCell: UICollectionViewCell {
     @IBOutlet weak var viewBG:UIView!
      @IBOutlet weak var lblTitle:UILabel!
    var objFilter:SpecializationModel?{
        didSet{
            lblTitle.text = objFilter?.name ?? ""
            if (objFilter?.isSelected!)!{
                viewBG.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.2235294118, blue: 0.2588235294, alpha: 1)
                lblTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                viewBG.backgroundColor = .white
            lblTitle.textColor =  #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 0.5)
            }
        }
    }
}
