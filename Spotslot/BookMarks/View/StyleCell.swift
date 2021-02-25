//
//  StyleCell.swift
//  Spotslot
//
//  Created by mac on 21/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//
/*
 "id": "8",
 "image": "https://anandisha.com/spot_slot/uploads/vendor_portfolio/1602852439_25.png",
 "profile_image": "https://anandisha.com/spot_slot/uploads/user/entertaiment-03.jpg",
 "user_id": "10",
 "vendor_id": "20",
 "portfolio_id": "13",
 "created_at": "2020-11-02 07:06:22",
 "updated_at": null,
 "deleted_at": null,
 "mark_type": "style"
 */

import UIKit

class StyleCell: UITableViewCell {
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var imgStyle: UIImageView!
    @IBOutlet weak var lblstyleName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblSpecilazation: UILabel!
    
    var objFavourite:Favorite?{
        didSet{
            imgProfilePic.sd_setImage(with: URL(string: objFavourite?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            imgStyle.sd_setImage(with: URL(string: objFavourite?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            lblstyleName.text = ""
            lblUserName.text = objFavourite?.user_name ?? ""
            lblSpecilazation.text = objFavourite?.name ?? ""
        }
    }
    
    var objAll:All?{
        didSet{
            imgProfilePic.sd_setImage(with: URL(string: objFavourite?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            imgStyle.sd_setImage(with: URL(string: objFavourite?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            lblstyleName.text = ""
            lblUserName.text = objFavourite?.user_name ?? ""
            lblSpecilazation.text = objFavourite?.name ?? ""
        }
    }
    
    var objPortFolio:VendorPortfolio?{
        didSet{
            imgProfilePic.sd_setImage(with: URL(string: objPortFolio?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            imgStyle.sd_setImage(with: URL(string: objPortFolio?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            lblstyleName.text = ""
            lblUserName.text =  objPortFolio?.user_name ?? ""
            lblSpecilazation.text = objPortFolio?.name ?? ""
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.height/2
        imgProfilePic.clipsToBounds = true
        imgProfilePic.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
        imgProfilePic.layer.borderWidth = 1.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
