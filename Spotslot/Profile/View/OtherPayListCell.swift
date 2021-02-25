//
//  TableViewCell.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class OtherPayListCell: UITableViewCell {
    
    @IBOutlet weak var imgPaymentIcons: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    
    var openBottomSheet:(()->Void)?
    
    var obj:PaymentMethodList?{
        didSet{
            if (obj?.payment_type ?? "") == "2"{
                self.imgPaymentIcons.image = UIImage(named: "apple_pay")
            }else if (obj?.payment_type ?? "") == "3"{
                self.imgPaymentIcons.image = UIImage(named: "logos_google-pay")
            }
            lblEmail.text = obj?.email ?? ""
        }
    }
    
    func openToEditAndDelete(didTapToOpen:@escaping()->Void){
        self.openBottomSheet = didTapToOpen
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func btnOpenBottomSheet(_ sender: UIButton) {
        openBottomSheet?()
    }
    
}
