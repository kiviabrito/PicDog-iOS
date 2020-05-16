//
//  FeedEntity.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation

struct FeedEntity: Codable {
  
  let category: String
  let list: [String]
  
  init(_ category: String,_ list: [String]) {
    self.category = category
    self.list = list
  }
  
}

extension FeedEntity: Equatable {
  
  static func == (lhs: FeedEntity, rhs: FeedEntity) -> Bool {
    return
      lhs.category == rhs.category &&
        lhs.list == rhs.list
  }
  
}
