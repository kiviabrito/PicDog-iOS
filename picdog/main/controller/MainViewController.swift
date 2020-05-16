//
//  BaseMainViewController.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit
import SDWebImage

class BaseMainViewController: UIViewController {
  
  // MARK: - Properties
  
  private var mainView : MainView { return self.view as! MainView }
  private var data = [] as! [String]
  
  var viewModel: MainViewModel?
  var indexPage: Int?
  
  // MARK: - Init
  
  override func loadView() {
    self.view = MainView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setCollectionView()
    if let index = indexPage {
      self.mainView.progressSpinner.startAnimating()
      self.viewModel?.setIndex(index: index)
    }
    subscribeObservers()
  }
  
  private func setCollectionView() {
    self.mainView.collectionView.dataSource = self
    self.mainView.collectionView.delegate = self
    self.mainView.collectionView.register(DogPictureCellView.self, forCellWithReuseIdentifier: DogPictureCellView.identifier)
  }
  
  // MARK: - Handle Observers
  
  func subscribeObservers() {
    viewModel?.feedResponse.observe = { (dictionary) in
      self.mainView.progressSpinner.stopAnimating()
      if ( dictionary.first!.key ==  self.indexPage ) {
        self.data = dictionary.first!.value.list
        self.mainView.collectionView.reloadData()
      }
    }
    viewModel?.errorResponse.observe = { (value) in
      self.mainView.progressSpinner.stopAnimating()
      self.showToast(message: value)
    }
  }
  
    // MARK: - Handle Expanded Image
  
  func showExpendedImage(_ picture: String) {
    let expandedView = self.view.viewWithTag(55)
    if expandedView != nil{
      expandedView!.removeFromSuperview()
    } else {
      // ImageView that displays the picture
      let newImageView = UIImageView()
      newImageView.backgroundColor = .clear
      newImageView.contentMode = .scaleAspectFit
      newImageView.sd_setImage(with: URL(string: picture), placeholderImage: UIImage(named: "ic_pets"))
      
      // UIView container, where the imageView is located
      let containerView = UIView()
      containerView.isUserInteractionEnabled = true
      let tap = UITapGestureRecognizer(target: self, action: #selector(dismissExpendedImage(_:)))
      containerView.addGestureRecognizer(tap)
      containerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
      containerView.tag = 55
      
      // Constrains
      newImageView.translatesAutoresizingMaskIntoConstraints = false
      containerView.addSubview(newImageView)
      NSLayoutConstraint.activate([
        newImageView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width - 50),
        newImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        newImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
        newImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
      ])
      containerView.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(containerView)
      NSLayoutConstraint.activate([
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      ])
    }
  }
  
  @objc func dismissExpendedImage(_ sender: UITapGestureRecognizer) {
    sender.view?.removeFromSuperview()
  }
  
}

// MARK: - Collection View Data Source

extension BaseMainViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return self.data.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogPictureCellView.identifier, for: indexPath) as! DogPictureCellView
    let data = self.data[indexPath.item]
    let transformer = SDImageResizingTransformer(size: CGSize(width: 300, height: 300), scaleMode: .aspectFill)
    cell.dogPicture.sd_setImage(with: URL(string: data), placeholderImage: nil,  context: [.imageTransformer: transformer])
    return cell
  }
  
}

// MARK: - Collection View Delegate

extension BaseMainViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let data = self.data[indexPath.item]
    showExpendedImage(data)
  }
  
}

// MARK: - Collection View Delegate Flow Layout

extension BaseMainViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let collectionViewSize = collectionView.frame.size.width
    return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}

