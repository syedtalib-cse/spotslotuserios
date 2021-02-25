//
//  GroupListCell.swift
//  Spotslot
//
//  Created by mac on 20/10/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class GroupListCell: UITableViewCell {
  
        @IBOutlet weak var lblGroupName: UILabel!
        @IBOutlet weak var lblMethodType: UILabel!
        @IBOutlet weak var lblMethodValue: UILabel!
        @IBOutlet weak var lblNumberofPerson: UILabel!
        @IBOutlet weak var imgSwitch: UIImageView!
        @IBOutlet weak var imgRadio: UIImageView!
    
    var didTapToSelected: (() -> Void)?
    
    var objData:Service_list?{
        didSet{
            lblGroupName.text = "\(objData?.group_name ?? "")"
            if let methodType = objData?.group_method_type {
                if methodType == "1"{
                    lblMethodType.text = "Discount"
                    lblMethodValue.text = objData?.price_discount ?? ""
                }else if methodType == "2"{
                    lblMethodType.text = "Price Cut"
                    lblMethodValue.text = "\(GenralText.currency.rawValue) \(objData?.price_discount ?? "")"
                }else{
                    lblMethodType.text = "None"
                }
            }
            lblNumberofPerson.text = objData?.minimum_people ?? ""
        }
    }
       
    func didTapToSelect(didTapToSelect: @escaping ()-> Void) {
        didTapToSelected = didTapToSelect
    }
    
    @IBAction func btnChecked(_ sender: Any) {
        didTapToSelected?()
    }
    
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
}
