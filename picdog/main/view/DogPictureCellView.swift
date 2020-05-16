//
//  DogCollectionCellView.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

class DogPictureCellView: UICollectionViewCell {
  
  // MARK: - Properties
  
  static var identifier: String = "DogPictureCellView"
  
  lazy var container: UIView = {
    return UIView()
  }()
    
  lazy var dogPicture: UIImageView = {
    let label = UIImageView()
    return label
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // add shadow on cell
    container.backgroundColor = .clear // very important
    container.layer.masksToBounds = true
    container.layer.shadowOpacity = 0.23
    container.layer.shadowRadius = 4
    container.layer.shadowOffset = CGSize(width: 0, height: 0)
    container.layer.shadowColor = UIColor.black.cgColor
    
    container.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(container)
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: self.topAnchor,constant: 2),
      container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
      container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
      container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
    ])
    
    dogPicture.layer.masksToBounds = true
    dogPicture.layer.borderWidth = 5
    dogPicture.layer.borderColor = UIColor.white.cgColor
    dogPicture.layer.cornerRadius = dogPicture.bounds.width / 2
    
    dogPicture.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(dogPicture)
    NSLayoutConstraint.activate([
      dogPicture.heightAnchor.constraint(equalToConstant: self.contentView.frame.size.width - 10),
      dogPicture.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      dogPicture.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
      dogPicture.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
    ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
