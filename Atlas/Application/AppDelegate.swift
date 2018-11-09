//
//  AppDelegate.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/6/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let applicationAssembly: ApplicationAssemblyType = ApplicationAssembly(applicationConfig: StageApplicationConfig())
    var applicationRouter: ApplicationRouterType?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupApplication()
        applicationRouter?.routeToMainView()
        return false
    }

    func setupApplication() {
        applicationRouter = ApplicationRouter(applicationAssembly: applicationAssembly, window: window)
        applicationAssembly.applicationRouter = applicationRouter
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

