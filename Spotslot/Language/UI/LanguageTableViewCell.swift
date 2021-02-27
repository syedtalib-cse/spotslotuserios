//
//  LanguageTableViewCell.swift
//  SplotslotVendor
//
//  Created by jaipee on 30/01/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet private weak var checkmarkImageView: UIImageView!
    @IBOutlet private weak var languageNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfiguration(_ model: LanguageModel) {
        checkmarkImageView.image = model.selected ? UIImage(named: "check_rounded") : UIImage(named: "Uncheck")
        languageNameLabel.text = model.languageName
    }
}
