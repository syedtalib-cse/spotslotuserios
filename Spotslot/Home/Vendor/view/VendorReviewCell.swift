//
//  VendorReviewCell.swift
//  Spotslot
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 Sunil kumar. All rights reserved.
//

import UIKit
import HCSStarRatingView
class VendorReviewCell: UICollectionViewCell {
    @IBOutlet weak var viewRatting: HCSStarRatingView!
    @IBOutlet weak var lblMessage:UILabel!
    @IBOutlet weak var lblVendorName:UILabel!
    @IBOutlet weak var lblRatingDate:UILabel!
    
    var objRating:Rating_list?{
        didSet{
            lblMessage.text = objRating?.review ?? ""
            lblVendorName.text = objRating?.name ?? ""
            let date = GlobalObj.ConevertRequriedDateFormate(dateStr: objRating?.created_at ?? "")
            lblRatingDate.text = date
            if let rating = Double(objRating?.rating ?? "0"){
                viewRatting.value = CGFloat(rating)//rating
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  

}
