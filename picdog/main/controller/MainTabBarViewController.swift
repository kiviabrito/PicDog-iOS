//
//  MainContainerViewController.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
  
  // MARK: - Properties
  
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  var viewModel : MainViewModel?
  
  // MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    viewModel = MainViewModel(application: appDelegate)
    setTabs()
    setSignOutButton()
  }
  
  func setTabs() {
    let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
    
    let huskyVC = BaseMainViewController()
    huskyVC.indexPage = 0
    huskyVC.viewModel = self.viewModel
    huskyVC.tabBarItem = UITabBarItem(title: "Husky", image: UIImage(named: "ic_husky"), tag: 0)
    huskyVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
    
    let houndVC = BaseMainViewController()
    houndVC.indexPage = 1
    houndVC.viewModel = self.viewModel
    houndVC.tabBarItem = UITabBarItem(title: "Hound", image: UIImage(named: "ic_hound"), tag: 1)
    houndVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
    
    let pugVC = BaseMainViewController()
    pugVC.indexPage = 2
    pugVC.viewModel = self.viewModel
    pugVC.tabBarItem =  UITabBarItem(title: "Pug", image: UIImage(named: "ic_pug"), tag: 2)
    pugVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
    
    let labradorVC = BaseMainViewController()
    labradorVC.indexPage = 3
    labradorVC.viewModel = self.viewModel
    labradorVC.tabBarItem =  UITabBarItem(title: "Labrador", image: UIImage(named: "ic_labrador"), tag: 3)
    labradorVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
    
    let tabBarList = [huskyVC, houndVC, pugVC, labradorVC]
    
    self.viewControllers = tabBarList
    self.tabBar.tintColor = .white
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.barTintColor = UIColor(named: "color_primary")!
      self.tabBar.barTintColor =  UIColor(named: "color_primary")!
    } else {
      self.navigationController?.navigationBar.barTintColor = .green
      self.tabBar.barTintColor  = .systemGreen
    }
  }
  
  override func viewDidLayoutSubviews() {
    tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 60)
    super.viewDidLayoutSubviews()
  }
  
  func setSignOutButton() {
    let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOutToggle))
    self.navigationItem.rightBarButtonItem = signOutButton
  }
  
  // MARK: - Handle Buttons
  
  @objc func handleSignOutToggle() {
    if self.viewModel?.signOut() ?? false {
      let alert = UIAlertController(title: "Sign Out", message: "Click OK to sing out.", preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
        self.navigationController?.pushViewController(AuthViewController(), animated: true)
      }))
      alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
      // show the alert
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  // MARK: - Discart ViewController
  
  override func viewWillDisappear(_ animated: Bool) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
