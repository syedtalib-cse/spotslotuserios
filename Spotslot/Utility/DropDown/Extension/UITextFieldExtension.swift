//
//  UITextFieldExtension.swift
//  RA_Swift
//
//  Created by Shiv Mohan Singh on 17/11/18.
//  Copyright © 2018 Bruce. All rights reserved.
//

import Foundation
import UIKit
private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
//        if let prospectiveText = self.text,
//            prospectiveText.count > maxLength{
//            SVProgressHUD.showInfo(withStatus: "Project name can't be greate than 100 words")
//        }
        
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }

        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}
