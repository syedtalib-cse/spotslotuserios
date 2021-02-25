//
//  HomeCell.swift
//  Spotslot
//
//  Created by mac on 21/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import SDWebImage
class HomeCell: UITableViewCell {
    
    @IBOutlet weak var imgBookMarked: UIImageView!
    @IBOutlet weak var imgTopBanner: UIImageView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var viewGold: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVeriFy: UIImageView!
    @IBOutlet weak var imgBDS: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    
    var didTapToShare:(()->Void)?
    var didTapToBookMark:(()->Void)?
    
    var vendorObj:VendorlistModel?{
        didSet{
            imgTopBanner.sd_setImage(with: URL(string: vendorObj?.background_img ?? ""), placeholderImage: UIImage(named: "placeholder"))
            imgUserProfile.sd_setImage(with: URL(string: vendorObj?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))

            lblUserName.text = vendorObj?.user_name ?? ""
            lblName.text = ""
            if vendorObj?.criminal_record_status! == "1"{
               imgBDS.image = UIImage(named: "DBS")
            }else{
               imgBDS.image = UIImage(named: "not_verified_criminal_record")
            }
             if vendorObj?.is_profile_verify! == "1"{
                imgVeriFy.image = UIImage(named: "checkIcons")
            }else{
                imgVeriFy.image = UIImage(named: "unverified")
            }
            lblRating.text = "\(vendorObj?.vendor_avag_rating ?? 0)"
            if vendorObj?.isBookmark == 1{
                imgBookMarked.image = UIImage(named: "bookedmark")
            }else{
                imgBookMarked.image = UIImage(named: "bookmark")
            }
        }
    }
    
    
    var objAll:All?{
           didSet{
               imgTopBanner.sd_setImage(with: URL(string: vendorObj?.background_img ?? ""), placeholderImage: UIImage(named: "placeholder"))
               imgUserProfile.sd_setImage(with: URL(string: vendorObj?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
               lblName.text = vendorObj?.user_name ?? ""
               lblUserName.text = vendorObj?.name ?? ""
               if vendorObj?.criminal_record_status! == "1"{
                  imgBDS.image = UIImage(named: "DBS")
               }else{
                  imgBDS.image = UIImage(named: "not_verified_criminal_record")
               }
                if vendorObj?.is_profile_verify! == "1"{
                   imgVeriFy.image = UIImage(named: "checkIcons")
               }else{
                   imgVeriFy.image = UIImage(named: "unverified")
               }
               lblRating.text = "\(vendorObj?.vendor_avag_rating ?? 0)"
//            if objAll?.isBookmark == 1{
//            imgBookMarked.image = UIImage(named: "bookedmark")
//            }else{
//            imgBookMarked.image = UIImage(named: "bookmark")
//            }
           }
          
       }
       
    var objSearchVendor:Vendors?{
           didSet{
              // imgTopBanner.sd_setImage(with: URL(string: vendorObj?.background_img ?? ""), placeholderImage: UIImage(named: "placeholder"))
              // imgUserProfile.sd_setImage(with: URL(string: vendorObj?.profile_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
//               lblName.text = vendorObj?.user_name ?? ""
//               lblUserName.text = vendorObj?.name ?? ""
//               if vendorObj?.criminal_record_status! == "1"{
//                  imgBDS.image = UIImage(named: "DBS")
//               }else{
//                  imgBDS.image = UIImage(named: "not_verified_criminal_record")
//               }
//                if vendorObj?.is_profile_verify! == "1"{
//                   imgVeriFy.image = UIImage(named: "checkIcons")
//               }else{
//                   imgVeriFy.image = UIImage(named: "unverified")
               //}
               lblRating.text = "\(vendorObj?.vendor_avag_rating ?? 0)"
               if vendorObj?.isBookmark == 1{
                   imgBookMarked.image = UIImage(named: "bookedmark")
               }else{
            
                   imgBookMarked.image = UIImage(named: "bookmark")
               }
           }
       }
    
  
    
    func didTapOnButton(didTapToShare:@escaping()->Void,didTapToBookmark:@escaping()->Void){
        self.didTapToShare = didTapToShare
        self.didTapToBookMark = didTapToBookmark
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.imgTopBanner.roundedTop(width: 16, height: 16)
            self.imgUserProfile.layer.cornerRadius = self.imgUserProfile.frame.height/2
            self.imgUserProfile.borderColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
            self.imgUserProfile.borderWidth = 1.5
            self.viewGold.layer.cornerRadius = self.viewGold.frame.height/2
        }
       
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    @IBAction func btnBookMark(_ sender: Any) {
        didTapToBookMark?()
    }
    
    @IBAction func btnShare(_ sender: Any) {
        didTapToShare?()
    }
    
    
}
