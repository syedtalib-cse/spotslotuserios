//
//  PortfolioSliderCollectionViewCell.swift
//  Spotslot
//
//  Created by jaipee on 26/02/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import UIKit
import SDWebImage

class PortfolioSliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgPortfolio:UIImageView!
    @IBOutlet weak var btnLikeDislike:UIButton!
    var completionHandler: ((Bool, PortfolioSliderCollectionViewCell)->Void)?
    var objVendorPortfolio:VendorPortfolio?{
        didSet{
            imgPortfolio.sd_setImage(with: URL(string: objVendorPortfolio?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            print(objVendorPortfolio?.isFavorite)
            btnLikeDislike.isSelected = objVendorPortfolio?.isFavorite ?? 0 == 0 ? false : true
            btnLikeDislike.superview?.setViewShadow(opacity: 1.0, cRadius: 20)
        }
    }
    
    
    
    @IBAction func btnLikeDislikeAction(_ sender: UIButton) {
        completionHandler?(!sender.isSelected, self)
    }
}
