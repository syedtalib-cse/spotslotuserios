//
//  LanguageCell.swift
//  Spotslot
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblLanguageName: UILabel!
    @IBOutlet weak var ingCountry: UIImageView!
    
    var modelObj:LanguageListModel?{
        didSet{
            lblLanguageName.text = modelObj?.name
            ingCountry?.image = UIImage(named:modelObj!.imageName!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
