//
//  AuthViewModel.swift
//  picdog
//
//  Created by Kivia on 5/15/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation

class AuthViewModel {
  
  // MARK: - Properties
  
  // Emits Error Response
  let errorResponse: Observable<String> = Observable()
  
  // Emits user Response
  let userResponse: Observable<UserEntity> = Observable()
  
  // Emits Sign Up Check
  let isSignUp: Observable<Bool> = Observable()
  
  var clientApi: ClientApi?
  var dataBase : AppDataBase?
  
  // MARK: - Init
  
  init(application: AppDelegate) {
    Thread.printCurrent(method: "init - AuthViewModel")
    dataBase = application.dataBase
    clientApi = application.clientApi
  }
  
  // MARK: - Sign Up
  
  func signUp(email: String) {
    Dispatch.background {
      self.clientApi?.signUpRequest(email: email, completionHandler: { (response) in
        switch (response) {
        case .SucessResponse(let response): do {
          self.dataBase?.insertUserEntityTable(entity: response.user)
          self.userResponse.value = response.user
          }
        case .ErrorResponse(let message): do {
          self.errorResponse.value = message
          }
        }
      })
    }
  }
  
  // MARK: - Sign Up Verification
  
  func checkIfIsSignUp() {
    Dispatch.background {
      if (self.dataBase?.selectAllUserEntityTable().first) != nil {
        self.isSignUp.value = true
      } else {
        self.isSignUp.value = false
      }
    }
  }
  
}

