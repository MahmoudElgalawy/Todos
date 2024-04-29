//
//  detailsVC.swift
//  TodoList
//
//  Created by Mahmoud  on 08/03/2024.
//

import UIKit

class detailsVC: UIViewController {

    @IBOutlet weak var todoTitle: UILabel!
    
    
    @IBOutlet weak var detailsLbl: UILabel!
    

    @IBOutlet weak var detailsPhoto: UIImageView!
    var todo:Todo!
    var index : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        getdata()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(todoUpdated), name: NSNotification.Name("TodoEdited"), object: nil)
        
    }
    
    func getdata(){
        if todo.image != nil {
            detailsLbl.text = todo.details
            todoTitle.text = todo.title
            detailsPhoto.image = todo.image
                }else {
                    detailsLbl.text = todo.details
                    todoTitle.text = todo.title
                    detailsPhoto.image = UIImage(systemName: "photo.circle")
                }
        
    }
    
    @objc func todoUpdated(notification:Notification){
        if let todo_1 = notification.userInfo?["EditedTodo"]as? Todo{
            self.todo = todo_1
            getdata()
        }
    }

    @IBAction func detailsUdateBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NewTodo") as? NewTodoVC {
            
            vc.isCreating = false
            vc.editedTodoIndex = index
            vc.todo = todo
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func detailsDeleteBtn(_ sender: Any) {
//        let alert = MyAlertViewController(
//            title: "انتبه",
//            message: "ستقوم بحذف المهمة",
//            imageName: "warning_icon")
//
//        alert.addAction(title: "الغاء", style: .cancel)
//        alert.addAction(title: "حذف", style: .default) { CleanyAlertAction in
//            NotificationCenter.default.post(name: NSNotification.Name("tododelete"), object: nil, userInfo: ["todoDeleteIndex" : self.index])
//            self.navigationController?.popViewController(animated: true)
//        }
//
//        present(alert, animated: true, completion: nil)
        
        let alert = UIAlertController(title: "انتبه", message: "ستقوم بحذف المهمة", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "حذف", style: .destructive, handler: { action in
            NotificationCenter.default.post(name: NSNotification.Name("tododelete"), object: nil, userInfo: ["todoDeleteIndex" : self.index])
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    

}
