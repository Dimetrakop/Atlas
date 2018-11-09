//
//  ApplicationRouter.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationRouterType: class {
    func routeToMainView()
    func routeDown(filterItem: ListModelType)
    func routeToDetail(country: CountryModelType)
}

final class ApplicationRouter: ApplicationRouterType {
    private let appAssembly: ApplicationAssemblyType
    private let window: UIWindow?

    init(applicationAssembly: ApplicationAssemblyType, window: UIWindow?) {
        self.appAssembly = applicationAssembly
        self.window = window
    }

    func routeToMainView() {
        DispatchQueue.main.async { [weak self] in
            guard let sself = self else { return }
            let mainView = sself.appAssembly.mainTabBarController()
            sself.window?.rootViewController = mainView
            sself.window?.makeKeyAndVisible()
        }
    }

    func routeDown(filterItem: ListModelType) {
        if let navigationController = window?.rootViewController as? UITabBarController,
           let navigationVC = navigationController.selectedViewController as? UINavigationController {
            let regionsVC: RegionsViewController = appAssembly.regionsViewController() as RegionsViewController
            regionsVC.interactor?.filterItem = filterItem
            navigationVC.pushViewController(regionsVC, animated: true)
        }
    }

    func routeToDetail(country: CountryModelType) {
        if let navigationController = window?.rootViewController as? UITabBarController,
            let navigationVC = navigationController.selectedViewController as? UINavigationController {
            let detailVC: DetailsViewController = appAssembly.detailsViewController(country: country) as DetailsViewController
            navigationVC.pushViewController(detailVC, animated: true)
        }
    }
}
