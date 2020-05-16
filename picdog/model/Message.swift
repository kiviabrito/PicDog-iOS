//
//  Message.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation

struct Message: Codable {
  
  let message: String

  init(_ message: String) {
    self.message = message
  }
}
