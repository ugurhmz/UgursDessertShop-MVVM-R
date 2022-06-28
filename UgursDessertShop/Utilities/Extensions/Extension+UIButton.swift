//
//  Extension+UIButton.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//
import UIKit

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 25.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        self.titleLabel?.textColor = UIColor.white
    }
    
    static func animateView(_ viewToAnimate: UIView){
        UIView.animate(withDuration: 0.23, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.82, y: 0.82)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn) {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { _ in
               print("")
            }

        }

    }
    
    func shakeButton(){
        var animate = CABasicAnimation(keyPath: "position")
        animate.repeatCount = 4
        animate.autoreverses = true
        animate.duration = 0.02
        animate.fromValue = CGPoint(x: self.center.x - 3,
                                    y: self.center.y - 0.5)
        
        animate .toValue = CGPoint(x: self.center.x + 3.5,
                                   y: self.center.y + 0.5)
        layer.add(animate, forKey: "position")
    }
}
