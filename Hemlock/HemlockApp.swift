//
//  HemlockApp.swift
//  Hemlock
//
//  Created by WhitetailAni on 11/10/23.
//

import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let hostingController = UIHostingController(rootView: ContentView())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension UserDefaults {
    static var settings: UserDefaults {
        return UserDefaults(suiteName: "com.whitetailani.Hemlock.settings") ?? UserDefaults.standard
    }
}
