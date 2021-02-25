//
//  PortfoliCell.swift
//  Spotslot
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import SDWebImage
class PortfoliCell: UICollectionViewCell {
@IBOutlet weak var imgPortfolio:UIImageView!

    var objVendorPortfolio:VendorPortfolio?{
        didSet{
        imgPortfolio.sd_setImage(with: URL(string: objVendorPortfolio?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        }
    }

    
    
}
