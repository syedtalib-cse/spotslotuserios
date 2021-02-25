//
//  Button.swift
//  RA_Swift
//
//  Created By"Shiv Mohan Singh" on 03/01/17.
//  Copyright © 2017 Bruce. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}

