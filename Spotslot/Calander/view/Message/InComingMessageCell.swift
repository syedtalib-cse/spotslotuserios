//
//  SendMessageCell.swift
//  SplotslotVendor
//
//  Created by mac on 11/09/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class InComingMessageCell: UITableViewCell {

    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewMessageBuble: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    
    var obj:ChatModel?{
        didSet{
            lblMessage.text = obj?.message ?? ""
            lblTime.text = obj?.created_at ?? ""
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
        self.viewMessageBuble.roundedThreeCorner(width: 16, height: 16)
        }
        imgUser.layer.cornerRadius = imgUser.frame.height/2
        imgUser.layer.borderWidth = 1
        imgUser.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7294117647, blue: 0.7843137255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
