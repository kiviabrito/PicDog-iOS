//
//  SceneDelegate.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      
      let navController = UINavigationController(rootViewController: SplashViewController())
      navController.navigationBar.barStyle = .black
      navController.navigationBar.tintColor = .white      
      navController.setNavigationBarHidden(true, animated: true)
      navController.navigationBar.isTranslucent = false
      navController.navigationBar.barTintColor = UIColor(named: "color_primary")
      
      window.rootViewController = navController
      window.makeKeyAndVisible()
      
      self.window = window
      self.window?.overrideUserInterfaceStyle = .light
    }
    
    guard let _ = (scene as? UIWindowScene) else { return }
  }
  
  func addCustomTitle(navigationItem: UINavigationItem) {
    let label = UILabel()
    label.textColor = UIColor.white
    label.text = "PicDog"
    label.font = UIFont(name: "ArchitectsDaughter-Regular", size: 25)!
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
  }
  
}

