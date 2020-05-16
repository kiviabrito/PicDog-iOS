//
//  SplashViewController.swift
//  picdog
//
//  Created by Kivia on 5/15/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
  
  // MARK: - Properties
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private var viewModel : AuthViewModel?
  
  lazy var progressSpinner : UIActivityIndicatorView = {
    let progressSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    progressSpinner.hidesWhenStopped = true
    progressSpinner.color = .white
    progressSpinner.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(progressSpinner)
    NSLayoutConstraint.activate([
      progressSpinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      progressSpinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
    return progressSpinner
  }()
  
  // MARK: - Init
  
  override func loadView() {
    view = UIView()
    if #available(iOS 11.0, *) {
      view.backgroundColor = UIColor(named: "color_primary")
    } else {
      view.backgroundColor = UIColor.systemGreen
    }
    self.progressSpinner.startAnimating()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = AuthViewModel.init(application: appDelegate)
    viewModel?.checkIfIsSignUp()
    subscribeObservers()
  }
  
  // MARK: - Observers
  
  func subscribeObservers() {
    viewModel?.isSignUp.observe = { (success) in
      if (success) {
        self.openMainTabBarViewController()
      } else {
        let authViewController = AuthViewController()
        self.navigationController?.pushViewController(authViewController, animated: false)
      }
    }
  }
  
  // MARK: - Handle Sign Up Success
  
  func openMainTabBarViewController() {
    let tabBarController = MainTabBarViewController()
    if #available(iOS 11, *) {
      addCustomTitle(navigationItem: tabBarController.navigationItem)
    } else {
      let title = UIBarButtonItem(title: "PicDog", style: .done, target: nil, action: nil)
      tabBarController.navigationItem.leftBarButtonItem = title
    }
    self.navigationController?.pushViewController(tabBarController, animated: false)
  }
  
  func addCustomTitle(navigationItem: UINavigationItem) {
    let label = UILabel()
    label.textColor = UIColor.white
    label.text = "PicDog"
    label.font = UIFont(name: "ArchitectsDaughter-Regular", size: 25)!
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
  }
  
  // MARK: - Discart ViewController
  
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.dismiss(animated: true, completion: nil)
  }
  
}
