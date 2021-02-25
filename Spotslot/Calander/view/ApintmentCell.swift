//
//  ApintmentCell.swift
//  Spotslot
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//


/*
 "appointment_date": "2020-10-25",
 "booking_status": "0",
 "primary_slot": "10:00 AM",
 "secondary_slot": "11:00 AM",
 "vendor_id": "2",
 "vendor_image": "https://anandisha.com/spot_slot/uploads/user/entertaiment-03.jpg",
 "vendor_name": "Abhsihek"
 */


import UIKit
import SDWebImage

class ApintmentCell: UITableViewCell {

    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRegularBooking: UILabel!
    @IBOutlet weak var vendorUserName: UILabel!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var imgVendor: UIImageView!
    @IBOutlet weak var imgUserStyle: UIImageView!
    @IBOutlet weak var btnRate: UIButton!
    
    var didTapToRate:(()->Void)?
    let color1 = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
    let color2 = #colorLiteral(red: 0.09411764706, green: 0.7254901961, blue: 0.7803921569, alpha: 1)
    var objAppointment:Previous?{
        didSet{
            lblDate.text = objAppointment?.appointment_date ?? ""
            vendorUserName.text = objAppointment?.username ?? ""
            vendorName.text = objAppointment?.vendor_name ?? ""
            lblRate.text = "\(objAppointment?.avag_rating ?? 0)"
            imgVendor.sd_setImage(with: URL(string: objAppointment?.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            if objAppointment?.isRated == 1{
                btnRate.setGradientBackground(colorTop: color1, colorBottom: color2, radius: 8)
                btnRate.setTitle("Re-Book", for: .normal)
            }else{
                btnRate.setTitle("Rate", for: .normal)
                btnRate.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.7450980392, blue: 0.4117647059, alpha: 1)
            }
            
        }
    }
    
    func didTapToRate(didTapToRate:@escaping()->Void){
        self.didTapToRate = didTapToRate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
    
    @IBAction func btnRate(_ sender: UIButton) {
     didTapToRate?()
    }
    
    
    
}
