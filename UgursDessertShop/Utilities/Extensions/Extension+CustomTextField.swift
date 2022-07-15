//
//  Extension+CustomTextField.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 26.06.2022.
//

import UIKit

class CustomTextField : UITextField {
    
    
    let padding : CGFloat
    let height : CGFloat
    init(padding : CGFloat, height : CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: height)
    }
    
}

extension UITextField{

    func setLeftImage(imageName:String) {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(systemName:  imageName)
        self.rightView = imageView;
        self.leftViewMode = .always
    }
}
