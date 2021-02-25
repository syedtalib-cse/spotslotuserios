//
//  PartnerWithSpotslotCell.swift
//  Spotslot
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class PartnerWithSpotslotCell: UITableViewCell {
    
    
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblTextContent: UILabel!
    
    var content:String?{
        didSet{
            lblTextContent.text = content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblPoint.layer.cornerRadius = lblPoint.frame.height/2
        lblPoint.clipsToBounds  = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
