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
        let isRunningTests = NSClassFromString("XCTestCase") != nil
        guard !isRunningTests else { return true }
        
        let root = HomeBuilder.build(theme: AppTheme.shared)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.tintColor = .orange
        window.rootViewController = root
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
