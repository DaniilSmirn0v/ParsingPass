//
//  AppDelegate.swift
//  ParsingPass
//
//  Created by Даниил Смирнов on 14.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            window = UIWindow(frame: UIScreen.main.bounds)
            let rootViewController = MainViewController()
            window?.rootViewController = rootViewController
            window?.makeKeyAndVisible()
            return true
        }


}

