//
//  CalanderCell.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import  SDWebImage

class CalanderCell: UICollectionViewCell {

    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var imgTick: UIImageView!
     @IBOutlet weak var imgUser: UIImageView!
    
    var objUpcomming:Upcomming?{
        didSet{
            lblDate.text = objUpcomming?.appointment_date ?? ""
            lblTime.text = objUpcomming?.primary_slot ?? ""
            lblUserName.text = objUpcomming?.username ?? ""
            lblVendorName.text = "" //objUpcomming?.vendor_name ?? ""
            imgUser.sd_setImage(with: URL(string:objUpcomming?.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
       var objUpcomming2:Upcomming?{
           didSet{
               lblUserName.text = objUpcomming2?.username ?? ""
               lblVendorName.text = "" /*objUpcomming2?.vendor_name ?? ""*/
               imgUser.sd_setImage(with: URL(string:objUpcomming2?.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
           }
       }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
}
