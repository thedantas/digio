//
//  AppDelegate.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = DigioStoreViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)

        window.rootViewController = navigationController
        window.backgroundColor = .primaryColor
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
