//
//  UserResponse.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
  
  let user: UserEntity
  
  init(_ user: UserEntity) {
    self.user = user
  }
}
