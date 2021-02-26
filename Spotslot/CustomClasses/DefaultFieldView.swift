//
//  DefaultFieldView.swift
//  SplotslotVendor
//
//  Created by jaipee on 19/01/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import UIKit

class DefaultFieldView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        getViewBorderWithCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getViewBorderWithCornerRadius()
    }
    
    private func getViewBorderWithCornerRadius() {
        self.setRadiusBorderWithColor(borderWidth: 0.8, cRadius: 16, Color: UIColor(red: 211.0/255.0, green: 218.0/255.0, blue: 231.0/255.0, alpha: 1.0))
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class DefaultCurvedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        getViewBorderWithCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getViewBorderWithCornerRadius()
    }
    
    private func getViewBorderWithCornerRadius() {
        self.setRadiusBorderWithColor(borderWidth: 0, cRadius: 16, Color: .clear)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
