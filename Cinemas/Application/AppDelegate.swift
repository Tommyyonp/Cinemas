//
//  AppDelegate.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UINavigationController(rootViewController: HomeViewController())
        vc.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}
