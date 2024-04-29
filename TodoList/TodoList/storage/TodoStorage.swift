//
//  TodoStorage.swift
//  TodoList
//
//  Created by Mahmoud  on 20/04/2024.
//

import UIKit
import CoreData


class TodoStorage {
    static func storeTodo(_ todo: Todo){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
           let managedContext = appDelegate.persistentContainer.viewContext
           guard let todoEntity = NSEntityDescription.entity(forEntityName: "Todos", in: managedContext) else { return  }
           let todoObject = NSManagedObject.init(entity: todoEntity, insertInto: managedContext)
           todoObject.setValue(todo.title, forKey: "title")
           todoObject.setValue(todo.details, forKey: "details")
           todoObject.setValue(todo.Date, forKey: "date")
           if let image = todo.image {
               let imageData = image.jpegData(compressionQuality: 1)
               todoObject.setValue(imageData, forKey: "image")
           }
           
           do {
               try managedContext.save()
               print("======== success ========")
           }catch {
               print("======== error =========")
           }
       }
   
  static func getTodos () -> [Todo] {
       var todos: [Todo] = []
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return[]}
       let context = appDelegate.persistentContainer.viewContext
       let fetchRequest = NSFetchRequest <NSFetchRequestResult>(entityName: "Todos")
       do {
           let result = try context.fetch(fetchRequest) as! [NSManagedObject]
           for managedTodo in result {
               let title = managedTodo.value(forKey: "title") as! String
               let details = managedTodo.value(forKey: "details") as! String
               let date = managedTodo.value(forKey: "date") as! String
               
               var todoImage: UIImage? = nil
               if let imageFromContext = managedTodo.value(forKey: "image") as? Data {
                   todoImage = UIImage(data: imageFromContext)
               }
               
               
               let todo = Todo(image:todoImage ,title: title, Date: date,details: details)
               todos.append(todo)}
            
       }
       catch {
           print("========Error=======")}
       return todos
   }
   
   
   static func updateTodo(_ todo: Todo, _ index: Int){
           
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
           let context = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
           
           do {
               let result = try context.fetch(fetchRequest) as! [NSManagedObject]
               
               result[index].setValue(todo.title, forKey: "title")
               result[index].setValue(todo.details, forKey: "details")
               result[index].setValue(todo.Date, forKey: "date")
               if let image = todo.image {
                   let imageData = image.jpegData(compressionQuality: 1)
                   result[index].setValue(imageData, forKey: "image")
               }
               try context.save()
               
               
           }catch {
               print("======== Error =========")
           }
       }
   
  static func deleteTodo(_ index: Int){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
           let context = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
           do {
               let result = try context.fetch (fetchRequest) as! [NSManagedObject]
               let todoToDelete = result[index]
               context.delete(todoToDelete)
               
               try context.save()
           }
           catch{
               print (error)
           }
       }
}
