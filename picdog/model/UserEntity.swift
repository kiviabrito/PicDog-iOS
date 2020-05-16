//
//  UserEntity.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation

struct UserEntity: Codable {
  
  let _id: String
  let token: String
  let createdAt: String
  let updatedAt: String
  let __v: Int
  
  init(_ _id: String, _ token: String,_ createdAt: String,_ updatedAt: String,_ __v: Int) {
    self._id = _id
    self.token = token
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.__v = __v
  }
  
}

extension UserEntity: Equatable {
  
  static func == (lhs: UserEntity, rhs: UserEntity) -> Bool {
    return
      lhs.token == rhs.token &&
        lhs.createdAt == rhs.createdAt &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.__v == lhs.__v
  }
  
}
