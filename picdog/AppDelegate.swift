//
//  AppDelegate.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var clientApi : ClientApi?
  var dataBase: AppDataBase?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    self.dataBase = AppDataBase()
    self.clientApi = ClientApi()
    
    if #available(iOS 13, *) {} else {
      window = UIWindow(frame: UIScreen.main.bounds)
      
      let navController = UINavigationController(rootViewController: SplashViewController())
      navController.navigationBar.barStyle = .black
      navController.navigationBar.tintColor = .white
      navController.setNavigationBarHidden(true, animated: true)
      navController.navigationBar.isTranslucent = false
      navController.navigationBar.barTintColor = .systemGreen
      
      window?.rootViewController = navController
      window?.makeKeyAndVisible()
    }
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
}

