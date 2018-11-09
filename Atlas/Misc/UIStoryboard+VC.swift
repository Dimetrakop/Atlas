//
//  UIViewController.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    public func createViewController<T: UIViewController>(withId identifier: String = String(describing: T.self)) -> T {
        guard let viewController = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to load view controller with identifier \(identifier)")
        }
        return viewController
    }
}
