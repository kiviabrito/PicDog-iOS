//
//  AppDataBase.swift
//  picdog
//
//  Created by Kivia on 5/14/20.
//  Copyright © 2020 kiviabrito. All rights reserved.
//

import Foundation
import SQLite3


class AppDataBase {
  
  // MARK: - Init
  
  private var db: OpaquePointer?
  private var fileURL: URL?
  
  init() {
    Dispatch.backgroundSync {
      self.createDataBase()
    }
  }
  
  func createDataBase() {
    Thread.printCurrent(method: "createDataBase - AppDataBase" )
    self.fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      .appendingPathComponent("picdog.sqlite")
    if sqlite3_open_v2(fileURL!.path,&db, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_FULLMUTEX, nil) != SQLITE_OK {
      print("error opening database")
    }
    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS UserEntity (id TEXT PRIMARY KEY, token TEXT, createdAt TEXT, updatedAt TEXT, __v INTEGER)", nil, nil, nil) != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(db)!)
      print("error creating table: \(errmsg)")
    }
    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS FeedEntity (category TEXT PRIMARY KEY, list TEXT)", nil, nil, nil) != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(db)!)
      print("error creating table: \(errmsg)")
    }
  }
  
  // MARK: - User Table
  
  func insertOrUpdateUserEntityTable(entity : UserEntity) {
    Thread.printCurrent(method: "insertOrUpdateUserEntityTable - AppDataBase")
    let actualList = self.selectAllUserEntityTable()
    let filter = actualList.first { (user) -> Bool in
      user._id == entity._id
    }
    if let user = filter {
      self.updateUserEntityTable(newEntity: entity, id: user._id)
    } else {
      self.insertUserEntityTable(entity: entity)
    }
  }
  
  // UPDATE
  
  func updateUserEntityTable(newEntity: UserEntity, id: String) {
    var updateStatement: OpaquePointer?
    let updateStatementString =
    "UPDATE UserEntity SET token = '\(newEntity.token)', createdAt = '\(newEntity.createdAt)', updatedAt = '\(newEntity.updatedAt)', __v = '\(newEntity.__v)' WHERE id = '\(id)';"
    if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
      SQLITE_OK {
      if sqlite3_step(updateStatement) == SQLITE_DONE {
        print("Successfully updated row User: : \(newEntity). \n")
      } else {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("Could not update row.User: \(errmsg)\n")
        insertUserEntityTable(entity: newEntity)
      }
    } else {
      print("UPDATE statement is not prepared\n")
    }
    sqlite3_finalize(updateStatement)
  }
  
  // INSERT
  
  func insertUserEntityTable(entity: UserEntity) {
    var insertStatement: OpaquePointer?
    let insertStatementString = "INSERT INTO UserEntity (token, createdAt, updatedAt, __v) VALUES (?,?,?,?);"
    if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
      
      sqlite3_bind_text(insertStatement, 1, NSString(string: entity._id).utf8String, -1, nil)
      
      sqlite3_bind_text(insertStatement, 2, NSString(string: entity.token).utf8String, -1, nil)
      
      sqlite3_bind_text(insertStatement, 3, NSString(string: entity.createdAt).utf8String, -1, nil)
      
      sqlite3_bind_text(insertStatement, 4, NSString(string: entity.updatedAt).utf8String, -1, nil)
      
      sqlite3_bind_int(insertStatement, 5, Int32(entity.__v))
      
      if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("Successfully inserted row User: : \(entity). \n")
      } else {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure inserting User: \(errmsg)\n")
      }
      
    } else {
      print("INSERT statement is not prepared.\n")
    }
    sqlite3_finalize(insertStatement)
  }
  
  // SELECT
  
  func selectAllUserEntityTable() -> [UserEntity]{
    var queryStatement: OpaquePointer?
    var finalList = [] as! [UserEntity]
    let queryStatementString = "SELECT * FROM UserEntity;"
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
      while (sqlite3_step(queryStatement) == SQLITE_ROW) {
        
        guard let queryResultCol0 = sqlite3_column_text(queryStatement, 1) else {
          let errmsg = String(cString: sqlite3_errmsg(db)!)
          print("Query result is nil id: \(errmsg)\n")
          return finalList
        }
        let id = String(cString: queryResultCol0)
        
        guard let queryResultCol1 = sqlite3_column_text(queryStatement, 2) else {
          let errmsg = String(cString: sqlite3_errmsg(db)!)
          print("Query result is nil token: \(errmsg)\n")
          return finalList
        }
        let token = String(cString: queryResultCol1)
        
        guard let queryResultCol2 = sqlite3_column_text(queryStatement, 3) else {
          let errmsg = String(cString: sqlite3_errmsg(db)!)
          print("Query result is nil createdAt: \(errmsg)\n")
          return finalList
        }
        let createdAt = String(cString: queryResultCol2)
        
        guard let queryResultCol3 = sqlite3_column_text(queryStatement, 4) else {
          let errmsg = String(cString: sqlite3_errmsg(db)!)
          print("Query result is nil updatedAt: \(errmsg)\n")
          return finalList
        }
        let updatedAt = String(cString: queryResultCol3)
        
        let __v = sqlite3_column_int(queryStatement, 5)
        
        finalList.append(UserEntity(id,token,createdAt,updatedAt,Int(__v)))
      }
    } else {
      let errorMessage = String(cString: sqlite3_errmsg(db))
      print("Query is not prepared: \(errorMessage)\n")
    }
    sqlite3_finalize(queryStatement)
    print("Query Result USER: \n \(finalList)\n")
    return finalList
  }
  
  // DELETE
  
  func deleteAllUserEntityTable() {
    Thread.printCurrent(method: "deleteAllUserTable - AppDataBase")
    let deleteStatementString = "DELETE FROM UserEntity"
    var deleteStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
      SQLITE_OK {
      if sqlite3_step(deleteStatement) == SQLITE_DONE {
        print("\nSuccessfully deleted at User Table.")
      } else {
        print("\nCould not delete at User Table.")
      }
    } else {
      print("\nDELETE statement could not be prepared")
    }
    
    sqlite3_finalize(deleteStatement)
  }
  
  
  // MARK: - Feed Table
  
  func insertOrUpdateFeedEntityTable(entity : FeedEntity) {
    Thread.printCurrent(method: "insertOrUpdateFeedEntityTable - AppDataBase")
    let actualList = self.selectAllFeedEntityTable()
    let filter = actualList.first { (feed) -> Bool in
      feed.category == entity.category
    }
    if let feed = filter  {
      self.updateFeedEntityTable(newEntity: entity, category: feed.category)
    } else {
      self.insertFeedEntityTable(entity: entity)
    }
  }
  
  // UPDATE
  
  func updateFeedEntityTable(newEntity: FeedEntity, category: String) {
    var updateStatement: OpaquePointer?
    if let data = try? JSONEncoder().encode(newEntity.list) {
      let string = String(data: data, encoding: .utf8)!
      
      let updateStatementString = "UPDATE FeedEntity SET list = '\(string)' WHERE category = '\(category)';"
      if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
        
        if sqlite3_step(updateStatement) == SQLITE_DONE {
          print("Successfully updated row Feed: \(newEntity).\n")
        } else {
          let errmsg = String(cString: sqlite3_errmsg(db)!)
          print("Could not update row Feed: \(errmsg)\n")
        }
        
      } else {
        print("UPDATE statement is not prepared.\n")
      }
      
    } else {
      print("ERROR ENCODING LIST")
    }
    sqlite3_finalize(updateStatement)
  }
  
  // INSERT
  
  func insertFeedEntityTable(entity: FeedEntity) {
    var insertStatement: OpaquePointer?
    let insertStatementString = "INSERT INTO FeedEntity (category, list) VALUES (?,?);"
    let statement = sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)
    if  statement == SQLITE_OK {
      
      sqlite3_bind_text(insertStatement, 1, NSString(string: entity.category).utf8String, -1, nil)
      
      if let data = try? JSONEncoder().encode(entity.list) {
        let string = String(data: data, encoding: .utf8)!
        print("LIST STRING \(string)")
        
        sqlite3_bind_text(insertStatement, 2, NSString(string: string).utf8String, -1, nil)
      } else {
        print("ERROR ENCODING LIST")
      }
      
      if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("Successfully inserted row Feed: \(entity). \n")
      } else {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure inserting Feed1: \(errmsg)\n")
      }
      
    } else if statement == SQLITE_DONE {
      print("INSERT statement is DONE.\n")
    } else {
      let errmsg = String(cString: sqlite3_errmsg(db)!)
      print("failure inserting Feed2: \(errmsg)\n")
    }
    sqlite3_finalize(insertStatement)
  }
  
  // SELECT
  
  func selectAllFeedEntityTable() -> [FeedEntity]{
    var queryStatement: OpaquePointer?
    var finalList = [] as! [FeedEntity]
    let queryStatementString = "SELECT * FROM FeedEntity;"
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
      while (sqlite3_step(queryStatement) == SQLITE_ROW) {
        
        guard let queryResultCol1 = sqlite3_column_text(queryStatement, 0) else {
          let errorMessage = String(cString: sqlite3_errmsg(db))
          print("Query result is nil category: \(errorMessage)\n")
          return finalList
        }
        let category = String(cString: queryResultCol1)
        
        guard let queryResultCol2 = sqlite3_column_text(queryStatement, 1) else {
          let errorMessage = String(cString: sqlite3_errmsg(db))
          print("Query result is nil list: \(errorMessage)\n")
          return finalList
        }
        let listString = String(cString: queryResultCol2).data(using: .utf8)!
        
        if let list = try? JSONDecoder().decode([String].self, from: listString) {
          finalList.append(FeedEntity(category, list))
        }
      }
    } else {
      let errorMessage = String(cString: sqlite3_errmsg(db))
      print("Query is not prepared: \(errorMessage)\n")
    }
    sqlite3_finalize(queryStatement)
    print("Query Result FEED: \n \(finalList)\n")
    return finalList
  }
  
  // DELETE
  
  func deleteAllFeedEntityTable() {
    Thread.printCurrent(method: "deleteAllFeedEntityTable - AppDataBase")
    let deleteStatementString = "DELETE FROM FeedEntity"
    var deleteStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
      SQLITE_OK {
      if sqlite3_step(deleteStatement) == SQLITE_DONE {
        print("\nSuccessfully deleted at Feed Table.")
      } else {
        print("\nCould not delete at Feed Table.")
      }
    } else {
      print("\nDELETE statement could not be prepared")
    }
    
    sqlite3_finalize(deleteStatement)
  }
  
}
