//
//  AppDelegate.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let root = HomeBuilder.build()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.tintColor = AppTheme.shared.enabledBackgroundColor
        window.rootViewController = root
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
