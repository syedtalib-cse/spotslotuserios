//
//  ServiceCell.swift
//  Spotslot
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class ServiceCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblHourWithNumberOfperson: UILabel!
    @IBOutlet weak var lblServicesDescription: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var viewHour: UIView!
    @IBOutlet weak var imgRadio: UIImageView!
    
    
    var didTapToSelected: (() -> Void)?
    
    var objServices:Service_list?{
        didSet{
            lblServiceName.text = objServices?.service_name ?? objServices?.group_name ?? objServices?.subcription_name ?? objServices?.package_name ?? ""
            lblServicesDescription.text = objServices?.description ?? ""
            lblPrice.text = "\(GenralText.currency.rawValue) \(objServices?.price ?? "") "
            lblHourWithNumberOfperson.text = "\(objServices!.durantion ?? "" ) hr/person"
         }
    }
    
    
    func didTapToSelect(didTapToSelect: @escaping ()-> Void) {
       didTapToSelected = didTapToSelect
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
    }
    
    @IBAction func btnChecked(_ sender: Any) {
        didTapToSelected?()
    }
    
    
    
}
