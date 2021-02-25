//
//  AddresslistCell.swift
//  Spotslot
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//
/*
 var didTapTorxpand: (() -> Void)?
 didTapTorxpand?()

 func toexpandView(_ isOpen:Bool,didTapToAdd: @escaping ()-> Void,didTapToexpand:@escaping ()-> Void) {
       self.viewBottom.isHidden = isOpen ? false : true
       self.heightOfVIew.constant = isOpen ? 350 : 0
      self.heightofCard.constant = isOpen ? 180 :0
       self.didTapToAdd = didTapToAdd
       self.didTapTorxpand = didTapToexpand
       
   }
 */

import UIKit

class AddresslistCell: UITableViewCell {

    @IBOutlet weak var lblMainAdd: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var didTapToPerfomOperation:(() -> Void)?
    
    var objAddress:AddressListModel?{
        didSet{
            lblTitle.text = objAddress?.address_name ?? ""
            lblAddress.text =  objAddress?.location ?? ""
            if (objAddress?.main_address_status ?? "") == "1"{
                lblMainAdd.isHidden = false
            }else{
                lblMainAdd.isHidden = true
            }
        }
    }
    
    func toOpenBottomSheet(didTapToPerfomOperation: @escaping ()-> Void) {
        self.didTapToPerfomOperation = didTapToPerfomOperation
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
   
    @IBAction func btnOpenBottomPopUp(_ sender: Any) {
      didTapToPerfomOperation?()
    }
    
    
}
