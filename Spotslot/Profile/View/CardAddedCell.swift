//
//  CardAddedCell.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class CardAddedCell: UITableViewCell {

    @IBOutlet weak var lblAccountHolder: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var cardTypeName: UILabel!
    
    var openBottomSheet:(()->Void)?
    
    var obj:PaymentMethodList?{
        didSet{
            lblAccountHolder.text = obj?.card_holder_name ?? ""
            lblCardNumber.text = obj?.card_number ?? ""
            cardTypeName.text = obj?.payment_method ?? ""
        }
    }
    
    func openToEditAndDelete(didTapToOpen:@escaping()->Void){
        self.openBottomSheet = didTapToOpen
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnOpenBottomSheet(_ sender: Any) {
      openBottomSheet?()
    }
    
}
