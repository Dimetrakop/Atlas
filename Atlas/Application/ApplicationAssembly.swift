//
//  ApplicationAssembly.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import Foundation
import UIKit

typealias ImageSvgCache = NSCache<NSString, NSData>

protocol ApplicationAssemblyType: class {
    var applicationRouter: ApplicationRouterType? { get set }
    var appConfig: ApplicationConfigType { get }
    func networkManager() -> NetworkServiceType
    func mainTabBarController() -> MainTabBarController
    func detailsViewController(country: CountryModelType) -> DetailsViewController
    func regionsViewController() -> RegionsViewController
}

final class ApplicationAssembly: ApplicationAssemblyType {

    public weak var applicationRouter: ApplicationRouterType?
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var appConfig: ApplicationConfigType
    private let networkService: NetworkServiceType
    private let imageCache = ImageSvgCache()
    
    init(applicationConfig: ApplicationConfigType) {
        appConfig = applicationConfig
        
        networkService = {
            let netService = NetworkService(appSettings: applicationConfig)
            return netService
        }()
    }

    func networkManager() -> NetworkServiceType {
        return networkService
    }

    func mainTabBarController() -> MainTabBarController {
        let mainTabBarController: MainTabBarController = mainStoryboard.createViewController() as MainTabBarController

        if  let navigationController = mainTabBarController.children[0] as? UINavigationController,
            let regionsVC = navigationController.children[0] as? RegionsViewController {
            let regionsInteractor = RegionsVCInterctor(networkService: networkService, delegateView: regionsVC, appConfig: appConfig)
            regionsVC.interactor = regionsInteractor
            regionsVC.router = applicationRouter
        }
        
        if  let navigationController = mainTabBarController.children[1] as? UINavigationController,
            let searchVC = navigationController.children[0] as? SearchViewController {
            let searschInteractor = SearchVCInteractor(networkService: networkService, delegateView: searchVC)
            searchVC.interactor = searschInteractor
            searchVC.router = applicationRouter
        }
        return mainTabBarController
    }
    
    func regionsViewController() -> RegionsViewController {
        let regionsVC: RegionsViewController = mainStoryboard.createViewController() as RegionsViewController
        let regionsVCInteractor = RegionsVCInterctor(networkService: networkService, delegateView: regionsVC, appConfig: appConfig)
        regionsVC.interactor = regionsVCInteractor
        regionsVC.router = applicationRouter
        regionsVC.imageCache = imageCache
        return regionsVC
    }

    func detailsViewController(country: CountryModelType) -> DetailsViewController {
        let detailsVC: DetailsViewController = mainStoryboard.createViewController() as DetailsViewController
        let detailsVCInteractor = DetailsVCInteractor(networkService: networkService, delegateView: detailsVC, country: country)
        detailsVC.interactor = detailsVCInteractor
        detailsVC.router = applicationRouter
        detailsVC.imageCache = imageCache
        return detailsVC
    }
}
