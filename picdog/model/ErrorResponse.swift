//
//  ErrorResponse.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
  
  let error: Message
  
  init(_ error: Message) {
    self.error = error
  }
}
