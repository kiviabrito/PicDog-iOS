//
//  Extentions.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit


// MARK: - UIViewController

extension UIViewController {
  
  func showToast(message : String) {
    let fixedWidth = self.view.frame.size.width - ( (self.view.frame.size.width/8) * 2)
    let toastLabel = UITextView(frame: CGRect(x: self.view.frame.size.width/8, y: self.view.frame.size.height-100, width: fixedWidth, height: 35))
    toastLabel.backgroundColor = UIColor.lightGray
    toastLabel.textColor = UIColor.black
    toastLabel.textAlignment = .center;
    toastLabel.isEditable = false
    toastLabel.isScrollEnabled = false
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    let newSize = toastLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    toastLabel.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
      toastLabel.removeFromSuperview()
    })
  }
  
}

// MARK: - DispatchQueue

typealias Dispatch = DispatchQueue

extension Dispatch {
  
  static func background(_ task: @escaping () -> ()) {
    Dispatch.global(qos: .background).async {
      task()
    }
  }
  
  static func backgroundSync(_ task: @escaping () -> ()) {
    Dispatch.global(qos: .background).sync {
      task()
    }
  }
  
  static func main(_ task: @escaping () -> ()) {
    Dispatch.main.async {
      task()
    }
  }
}

// MARK: - Thread

extension Thread {
  
  class func printCurrent(method: String) {
    print("\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r" + "METHOD: \(method)\r")
  }
  
}

