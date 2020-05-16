//
//  AuthView.swift
//  picdog
//
//  Created by Kivia on 5/15/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

class AuthView : UIView {
  
  // MARK: - Properties
  
  var delegate : AuthViewDelegate?
  
  lazy var progressSpinner : UIActivityIndicatorView = {
    let progressSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    progressSpinner.hidesWhenStopped = true
    progressSpinner.color = .blue
    return progressSpinner
  }()
  
  lazy var gradientContainer : GradientView = {
    let container = GradientView(frame: self.bounds)
    return container
  }()
  
  lazy var stackView : UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 20
    return stackView
  }()
  
  lazy var welcomeLable : UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "ArchitectsDaughter-Regular", size: 25)!
    label.text = "Welcome to"
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  lazy var picDogLable : UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "ArchitectsDaughter-Regular", size: 25)!
    label.text = "PicDog"
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  lazy var appIcon : UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "ic_pets")
    return imageView
  }()
  
  lazy var emailInput : UITextField = {
    let txtField = UITextField()
    txtField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
    txtField.attributedPlaceholder = NSAttributedString(string: "  Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)])
    txtField.autocorrectionType = .no
    txtField.textColor = .white
    txtField.keyboardType = UIKeyboardType.emailAddress
    txtField.tintColor = .white
    txtField.layer.borderWidth = 1
    txtField.layer.borderColor = UIColor.gray.cgColor
    txtField.layer.cornerRadius = 10
    txtField.clipsToBounds = true
    let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
    txtField.leftView = paddingView
    txtField.leftViewMode = .always
    return txtField
  }()
  
  lazy var signOutButton : UIButton = {
    let button = UIButton()
    button.setTitle("SIGN UP", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 16)
    button.addTarget(self, action: #selector(signUp(_ :)), for: UIControl.Event.touchUpInside)
    button.tintColor = .white
    var backgroundLayer = GradientBackground().gl
    backgroundLayer!.frame = frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 100, height: 30))
    button.layer.insertSublayer(backgroundLayer!, at: 0)
    return button
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) { // Need receive userModel
    super.init(frame: frame)
    setUpAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUpAutoLayout() {
    backgroundColor = .white
    
    self.addSubview(gradientContainer)
    gradientContainer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      gradientContainer.topAnchor.constraint(equalTo: self.topAnchor),
      gradientContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      gradientContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      gradientContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    
    welcomeLable.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      welcomeLable.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
      welcomeLable.widthAnchor.constraint(equalToConstant: self.frame.size.width - 100)])
    
    picDogLable.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      picDogLable.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
      picDogLable.widthAnchor.constraint(equalToConstant: self.frame.size.width - 100)])
    
    appIcon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      appIcon.heightAnchor.constraint(equalToConstant: 60),
      appIcon.widthAnchor.constraint(equalToConstant: 60)])
    
    emailInput.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailInput.heightAnchor.constraint(equalToConstant: 40),
      emailInput.widthAnchor.constraint(equalToConstant: self.frame.size.width - 100)])
  
    signOutButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      signOutButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
      signOutButton.widthAnchor.constraint(equalToConstant: 100)])
    
    stackView.addArrangedSubview(welcomeLable)
    stackView.addArrangedSubview(picDogLable)
    stackView.addArrangedSubview(appIcon)
    stackView.addArrangedSubview(emailInput)
    stackView.addArrangedSubview(signOutButton)
    
    gradientContainer.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: gradientContainer.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: gradientContainer.centerYAnchor)])
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.addGestureRecognizer(tap)
    
    progressSpinner.translatesAutoresizingMaskIntoConstraints = false
    gradientContainer.addSubview(progressSpinner)
    NSLayoutConstraint.activate([
    progressSpinner.centerXAnchor.constraint(equalTo: gradientContainer.centerXAnchor),
    progressSpinner.centerYAnchor.constraint(equalTo: gradientContainer.centerYAnchor)])
    
  }
  
  // MARK: - Handle Buttons
  
  @objc func signUp(_ sender : UIButton) {
    delegate?.handleSignUp(button: sender )
  }
  
  @objc func dismissKeyboard() {
    emailInput.endEditing(true)
  }
  
}
