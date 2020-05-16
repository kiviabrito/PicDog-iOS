//
//  AuthViewController.swift
//  picdog
//
//  Created by Kivia on 5/15/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController , AuthViewDelegate, UITextFieldDelegate {
  
  // MARK: - Properties
  
  private var authView : AuthView { return self.view as! AuthView }
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private var viewModel : AuthViewModel?
  
  // MARK: - Init
  
  override func loadView() {
    self.view = AuthView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel = AuthViewModel(application: appDelegate)
    subscribeObservers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    authView.delegate = self
    authView.emailInput.delegate = self
    setupKeyboardNotifications()
  }
  
  // MARK: - Handle Sign Up
  
  func handleSignUp(button: UIButton) {
    self.authView.progressSpinner.startAnimating()
    let email = authView.emailInput.text
    if email != nil && email != "" {
      self.viewModel?.signUp(email: email!)
    } else {
      self.authView.progressSpinner.stopAnimating()
      self.showToast(message: "Please enter a email address")
    }
  }
  
  // MARK: - Observers
  
  func subscribeObservers() {
    self.viewModel?.userResponse.observe = { (user) in
      self.view.endEditing(true)
      self.authView.progressSpinner.stopAnimating()
      self.openMainTabBarViewController()
    }
    
    self.viewModel?.errorResponse.observe = { (message) in
      self.view.endEditing(true)
      self.authView.progressSpinner.stopAnimating()
      self.showToast(message: "Error: \(message)")
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
    self.navigationController?.pushViewController(tabBarController, animated: true)
  }
  
  func addCustomTitle(navigationItem: UINavigationItem) {
    let label = UILabel()
    label.textColor = UIColor.white
    label.text = "PicDog"
    label.font = UIFont(name: "ArchitectsDaughter-Regular", size: 25)!
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
  }
  
  // MARK: - Handle Keyboard Ajust
  
  func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  
  @objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    if notification.name == UIResponder.keyboardWillHideNotification {
      self.view.bounds.origin.y = 0
    } else {
      self.view.bounds.origin.y = keyboardViewEndFrame.height
    }
  }
  
  // MARK: - Close Keyboard
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.resignFirstResponder()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
  
  // MARK: Discart ViewController
  
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.dismiss(animated: true, completion: nil)
  }
  
}
