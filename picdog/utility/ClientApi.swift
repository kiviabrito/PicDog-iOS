//
//  ClientApi.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation

final class ClientApi {
  
  // MARK: - Init
  
  private let url = "https://iddog-nrizncxqba-uc.a.run.app/"
  private var session : URLSession?
  
  init() {
    session = URLSession.shared
  }
  
  // MARK: - SignUpRequest
  
  func signUpRequest(email: String , completionHandler: @escaping (SignUpResponse) -> Void){
    
    var request = URLRequest(url: URL(string: "\(url)/signup/?email=\(email)")!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let connection = session?.dataTask(with: request, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error accessing swapi.co: \(error)")
        completionHandler(SignUpResponse.ErrorResponse("Connection Error"))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(String(describing: response))")
        let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data!)
        completionHandler(SignUpResponse.ErrorResponse((errorResponse?.error.message)!))
        return
      }
      guard let data = data else { return }
      if let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data) {
        completionHandler(SignUpResponse.SucessResponse(userResponse))
      }
    })
    connection?.resume()
  }
  
  // MARK: - FeedRequest
  
  func feedRequest(category: String, token: String, completionHandler: @escaping (FeedResponse) -> Void){
    
    var request = URLRequest(url: URL(string: "\(url)/feed?category=\(category)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(token, forHTTPHeaderField: "Authorization")
    
    let connection = session?.dataTask(with: request, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error accessing swapi.co: \(error)")
        completionHandler(FeedResponse.ErrorResponse("Connection Error"))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(String(describing: response))")
        let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data!)
        completionHandler(FeedResponse.ErrorResponse((errorResponse?.error.message)!))
        return
      }
      guard let data = data else { return }
      if let feedResponse = try? JSONDecoder().decode(FeedEntity.self, from: data) {
        completionHandler(FeedResponse.SucessResponse(feedResponse))
      }
    })
    connection?.resume()
  }
  
}

