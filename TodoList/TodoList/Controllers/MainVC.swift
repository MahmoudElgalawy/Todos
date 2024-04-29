//
//  MainVC.swift
//  TodoList
//
//  Created by Mahmoud  on 08/03/2024.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    @IBOutlet weak var TableView: UITableView!
    var todoArr:[Todo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        self.todoArr = TodoStorage.getTodos()
       // language()
        // Add notification
        NotificationCenter.default.addObserver(self, selector: #selector(todoAdded), name: NSNotification.Name("NewTodoAdded"), object:nil)
        // Update notification
        NotificationCenter.default.addObserver(self, selector: #selector(todoUpdated), name: NSNotification.Name("TodoEdited"), object: nil)
        
        // delete notification
        NotificationCenter.default.addObserver(self, selector: #selector(todoDeleted), name: NSNotification.Name("tododelete"), object: nil)
        
    }
    
    @objc func todoAdded(notification : Notification){
        if let todo = notification.userInfo?["TodoAdded"] as? Todo {
            todoArr.append(todo)
            TableView.reloadData()
            TodoStorage.storeTodo(todo)
            
        }
    }
    
    @objc func todoUpdated(notification : Notification){
        if let todo = notification.userInfo?["EditedTodo"] as? Todo{
            if let index = notification.userInfo?["TodoEditedIndex"] as? Int {
               todoArr[index] = todo
                TableView.reloadData()
                TodoStorage.updateTodo(todo , index)
            }
        }}
    
    @objc func todoDeleted(notification : Notification){
        if let index = notification.userInfo?["todoDeleteIndex"] as? Int {
            todoArr.remove(at: index)
            TableView.reloadData()
            TodoStorage.deleteTodo(index)
        }
        
    }
    

    

}
extension MainVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
        let store = todoArr[indexPath.row]
        if store.image != nil {
            cell.setUp(image: store.image!, title: store.title, date: store.Date)}
        else{
                cell.TodoImg.image = UIImage(systemName: "photo.circle")
            cell.TodoImg.tintColor = UIColor.systemGray2
            cell.TodoTitleLbl.text = store.title
            cell.TodoDateLbl.text = store.Date
            }
        cell.TodoImg.layer.cornerRadius = cell.TodoImg.frame.width/2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let details = storyboard?.instantiateViewController(identifier: "detailsVC") as? detailsVC
        if let vc = details {
            vc.todo = todoArr[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            vc.index = indexPath.row
            
        }
        
    }
    
  
}




//extension MainVC {
//    func language (){
//        let currentLang = Locale.current.language.languageCode?.identifier
//        let newLang = currentLang == "en" ? "ar" : "en"
//        UserDefaults.standard.setValue(newLang, forKey: "AppleLanguages")
//    }}
