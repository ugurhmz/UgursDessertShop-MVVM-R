//
//  Extens.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 26.06.2022.
//

import UIKit

extension UIViewController {
    
    // customAlert
    func alertCustomFunc(title: String,
                         msg: String,
                         prefStyle: UIAlertController.Style,
                         fontSize: CGFloat,
                         textColor: UIColor,
                         bgColor: UIColor)
    {
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: prefStyle)
        let okAct = UIAlertAction(title: "OK", style: .default, handler: nil)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "GillSans-Italic", size: fontSize)!, NSAttributedString.Key.foregroundColor: textColor]
                
        let messageString = NSAttributedString(string: msg, attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = bgColor
        alert.addAction(okAct)
        present(alert, animated: true, completion: nil)
    }
    
    
        //MARK: - Create Alert
       func createAlert(title: String,
                        msg: String,
                        prefStyle: UIAlertController.Style,
                        bgColor: UIColor,
                        textColor: UIColor,
                        fontSize: CGFloat) {
           
           alertCustomFunc(title: title, msg: msg, prefStyle: prefStyle, fontSize: fontSize, textColor: textColor, bgColor: bgColor)
           
       }
       
       
       //MARK: - Handle Fire Auth Err
       func handleFireAuthError(error: Error,
                                fontSize: CGFloat,
                                textColor: UIColor,
                                bgColor: UIColor) {
           
//           if let errorCode = AuthErrorCode(rawValue: error._code) {
//               alertCustomFunc(title: "Error", msg:  errorCode.errorMessage, prefStyle: .alert, fontSize: fontSize, textColor: textColor, bgColor: bgColor)
//
//           }
       }
    
}
