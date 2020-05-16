//
//  GradienteView.swift
//  picdog
//
//  Created by Kivia on 5/15/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import UIKit

class GradientView: UIView {
  override open class var layerClass: AnyClass {
    return CAGradientLayer.classForCoder()
  }
  
  required override init(frame: CGRect) {
    super.init(frame: frame)
    let gradientLayer = layer as! CAGradientLayer
    if #available(iOS 11.0, *) {
      let dark = UIColor(named: "color_primaryDark")
      let light = UIColor(named: "color_primaryLight")
      let regular = UIColor(named: "color_primary")
      gradientLayer.colors = [dark!.cgColor, regular!.cgColor, light!.cgColor ]
    } else {
      let dark = UIColor.systemGreen
      let light = UIColor.green
      gradientLayer.colors = [dark.cgColor, light.cgColor ]
    }
    gradientLayer.startPoint = CGPoint.zero
    gradientLayer.endPoint  = CGPoint(x: 1, y: 1)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    let gradientLayer = layer as! CAGradientLayer
    if #available(iOS 11.0, *) {
      let dark = UIColor(named: "color_primaryDark")
      let light = UIColor(named: "color_primaryLight")
      let regular = UIColor(named: "color_primary")
      gradientLayer.colors = [dark!.cgColor, regular!.cgColor, light!.cgColor ]
    } else {
      let dark = UIColor.systemGreen
      let light = UIColor.green
      gradientLayer.colors = [dark.cgColor, light.cgColor ]
    }
    gradientLayer.startPoint = CGPoint.zero
    gradientLayer.endPoint  = CGPoint(x: 1, y: 1)
  }
}

class GradientBackground {
  var gl:CAGradientLayer!
  
  init() {
    self.gl = CAGradientLayer()
    
    if #available(iOS 11.0, *) {
      let colorTop = UIColor(named: "color_primaryDark")!.cgColor
      let colorBottom = UIColor(named: "color_primaryLight")!.cgColor
      self.gl.colors = [colorTop, colorBottom]
    } else {
      let colorTop = UIColor.systemGreen.cgColor
      let colorBottom = UIColor.green.cgColor
      self.gl.colors = [colorTop, colorBottom]
    }
    self.gl.locations = [0.0, 1.0]
    self.gl.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    self.gl.shadowOffset = CGSize(width: 0.0, height: 2.0)
    self.gl.shadowOpacity = 1.0
    self.gl.shadowRadius = 0.0
    self.gl.masksToBounds = false
    self.gl.cornerRadius = 10.0
  }
}
