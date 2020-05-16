//
//  MainViewModel.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation
import SDWebImage

class MainViewModel {
  
  // MARK: - Properties
    
  // Emits Error Response
  let errorResponse: Observable<String> = Observable()
  
  // Emits Feed Response
  let feedResponse: Observable<Dictionary<Int, FeedEntity>> = Observable()
  
  // MARK: - Init
  
  var clientApi: ClientApi?
  var dataBase : AppDataBase?
  
  init(application: AppDelegate) {
    Thread.printCurrent(method: "init - MainViewModel")
    dataBase = application.dataBase
    clientApi = application.clientApi
  }
  
  // MARK: - Fetch Feed
  
  func setIndex(index: Int) {
    switch index {
    case 0:
      try? getFeed("husky", 0)
    case 1:
      try? getFeed("hound", 1)
    case 2:
      try? getFeed("pug", 2)
    case 3:
      try? getFeed("labrador", 3)
    default:
      print("DEFAULT")
    }
  }
  
  func getFeed(_ category: String,_ index : Int) throws {
    Dispatch.background {
      do {
        let feed = self.dataBase?.selectAllFeedEntityTable().first(where: { (feed) -> Bool in
          feed.category == category
        })
        if let feed = feed {
          self.feedResponse.value = [index:feed]
        }
        try self.requestUpdateFromNetwork(category: category, feed: feed, index: index)
      } catch {
        self.errorResponse.value = "Connection Error"
      }
    }
  }
  
  func requestUpdateFromNetwork(category: String, feed: FeedEntity?, index: Int) throws {
    Dispatch.background {
      if let userEntity = self.dataBase?.selectAllUserEntityTable().first {
        self.clientApi?.feedRequest(category: category, token: userEntity.token) { (response) in
          switch (response) {
          case .SucessResponse(let response): do {
            self.handleSuccessResponse(feed: feed, response: response, index: index)
            }
          case .ErrorResponse(let message): do {
            self.errorResponse.value = message
            }
          }
        }
      }
    }
  }
  
  func handleSuccessResponse(feed: FeedEntity?, response: FeedEntity, index: Int) {
    Dispatch.background {
      if (feed != response) {
        Dispatch.main {
          self.feedResponse.value = [index:response]
        }
        self.dataBase?.insertOrUpdateFeedEntityTable(entity: response)
        Dispatch.main {
          self.cacheImage(list: response.list)
        }
      }
    }
  }
  
  // MARK: - Cache Images
  
  func cacheImage(list: [String]) {
    list.forEach { (imageUrl) in
      SDWebImageManager.shared.loadImage(
        with: URL(string: imageUrl),
        options: .continueInBackground,
        progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
          print("Finished loading: \(isFinished) \nImage: \(String(describing: imageUrl))\n")
      }
    }
  }
  
  // MARK: - Sign Out
  
  func signOut() -> Bool {
    Dispatch.background {
      self.dataBase?.deleteAllUserEntityTable()
      self.dataBase?.deleteAllFeedEntityTable()
      SDImageCache.shared.clearMemory()
      SDImageCache.shared.clearDisk(onCompletion: nil)
    }
    return true
  }
  
}
