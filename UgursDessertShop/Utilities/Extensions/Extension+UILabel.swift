//
//  Extension+UILabel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 10.07.2022.
//

import UIKit

// UILABEL UNDERLINE
extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.attributedText = attributedString
        }
    }
}
