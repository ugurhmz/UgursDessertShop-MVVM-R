//
//  Animator.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import UIKit
protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
