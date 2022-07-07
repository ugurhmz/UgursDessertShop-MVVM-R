//
//  UIActivityIndicatorView.swift
//  ChallengeApp
//
//  Created by ugur-pc on 9.05.2022.
//

import UIKit
public class ActivityIndicatorView: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        style = .gray
        tintColor = .red
        hidesWhenStopped = true
    }
    
}
