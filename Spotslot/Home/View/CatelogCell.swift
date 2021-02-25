//
//  CatelogCell.swift
//  Spotslot
//
//  Created by mac on 21/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import SDWebImage

class CatelogCell: UICollectionViewCell {
    @IBOutlet weak var imgPortFolio:UIImageView!
    
    var obj:Portfolio?{
        didSet{
            imgPortFolio.sd_setImage(with: URL(string: obj?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
}
