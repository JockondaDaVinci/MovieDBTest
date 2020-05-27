//
//  CoreDataManager.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 26.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import CoreData
import UIKit

struct DBManagedModel {
  var id: Int
  var title: String
}

enum CoreDataError: Error {
  case dataIsEmpty
}

class CoreDataManager {
  private var context: NSManagedObjectContext? {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    return appDelegate?.persistentContainer.viewContext
  }
  private let entityName = "Movie"
  
  static let shared = CoreDataManager()

  func store(_ object: ListItem) {
    guard let context = context,
      let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
      else { return }
    
    isObjectExists(object.id) { exists in
      if exists {
        delete(byID: object.id)
      } else {
        let movie = NSManagedObject(entity: entity, insertInto: context)
        movie.setValue(Int32(object.id), forKey: "movieID")
        movie.setValue(object.title, forKey: "title")
        
        do {
          try context.save()
        } catch {
          debugPrint(error.localizedDescription)
        }
      }
    }
  }
  
  private func isObjectExists(_ id: Int, completion: (Bool) -> Void) {
    guard let context = context else { return }
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    request.predicate = NSPredicate(format: "movieID==\(Int32(id))")
    
    do {
      let objects = try context.fetch(request)
      guard !objects.isEmpty else { throw CoreDataError.dataIsEmpty }
      completion(true)
    } catch {
      debugPrint(error.localizedDescription)
      completion(false)
    }
  }
  
  func retrieve(completion: ([DBManagedModel]?, Error?) -> Void) {
    guard let context = context else { return }
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    do {
      let result = try context.fetch(request)
      guard let data = result as? [NSManagedObject] else {
        completion(nil, CoreDataError.dataIsEmpty)
        return
      }
      let object = data.compactMap { data -> DBManagedModel in
        guard let id = data.value(forKey: "movieID") as? Int, let title = data.value(forKey: "title") as? String else {
          return DBManagedModel(id: -1, title: "Unwrapped")
        }
        return DBManagedModel(id: id, title: title)
      }
      completion(object, nil)
    } catch {
      debugPrint(error.localizedDescription)
    }
  }
  
  func delete(byID id: Int) {
    guard let context = context else { return }
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    request.predicate = NSPredicate(format: "movieID==\(Int32(id))")
    
    do {
      let objects = try context.fetch(request)
      for object in objects {
        guard let object = object as? NSManagedObject else { return }
        context.delete(object)
      }
      
      do {
        try context.save()
      } catch {
        debugPrint(error.localizedDescription)
      }
    } catch {
      debugPrint(error.localizedDescription)
    }
  }
}

