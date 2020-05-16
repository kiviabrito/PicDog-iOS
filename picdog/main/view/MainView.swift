//
//  MainView.swift
//  picdog
//
//  Created by Kivia on 5/15/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

class MainView: UIView {
  
  // MARK: - Properties
  
  lazy var collectionView : UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.backgroundColor = .lightGray
    let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(top: 63, left: 0, bottom: 0, right: 0)
    collectionView.contentInset = adjustForTabbarInsets
    collectionView.scrollIndicatorInsets = adjustForTabbarInsets
    return collectionView
  }()
  
  lazy var progressSpinner : UIActivityIndicatorView = {
    let progressSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    progressSpinner.color = .blue
    progressSpinner.hidesWhenStopped = true
    return progressSpinner
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
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
    
    progressSpinner.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(progressSpinner)
    NSLayoutConstraint.activate([
      progressSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      progressSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    
  }
  
  
}
