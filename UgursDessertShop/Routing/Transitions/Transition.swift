//
//  Transition.swift
//  MovieCase
//
//  Created by ugur-pc on 11.05.2022.
//


import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
