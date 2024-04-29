//
//  NewTodo.swift
//  TodoList
//
//  Created by Mahmoud  on 14/03/2024.
//

import UIKit

class NewTodoVC: UIViewController {

    
    @IBOutlet weak var todoTitletxt: UITextField!
    
    @IBOutlet weak var mainBtn: UIButton!
    
    
    @IBOutlet weak var todoDetails: UITextView!
    @IBOutlet weak var changeImg: UIButton!
    @IBOutlet weak var todoImg: UIImageView!
    
    var todo :Todo?
    var isCreating:Bool = true
    var editedTodoIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCreating == false {
            mainBtn.setTitle("تعديل", for: .normal)
            changeImg.setTitle("تغيير الصورة", for: .normal)
            
            navigationItem.title = "تعديل المهمة"
        
            
            if let editedTodo = todo {
                todoImg.image = editedTodo.image
                todoTitletxt.text = editedTodo.title
                todoDetails.text = editedTodo.details
            }
            
            
            let btnback2 = UIBarButtonItem()
            btnback2.title = "عودة"
            btnback2.tintColor = UIColor.black
            btnback2.target = self
            btnback2.action = #selector(back)
            navigationItem.leftBarButtonItem = btnback2
            
        }
       
    }
    

    @IBAction func addPhotoBtn(_ sender: Any) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        present(imgPicker,animated: true)
        
    }
    
    @IBAction func todoMainBtn(_ sender: Any) {
        let currentDate = getDate()
        
        if isCreating {
            let alert = UIAlertController(title: "اضافة مهمة", message: "هل انت متآكد من اضافة مهمة جديدة", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "اضافة", style: .default, handler : { action in
                let todo = Todo(image : self.todoImg.image,title:self.todoTitletxt.text!, Date: currentDate ,details: self.todoDetails.text)
                NotificationCenter.default.post(name: NSNotification.Name("NewTodoAdded"), object: nil, userInfo: ["TodoAdded" : todo ])
                self.tabBarController?.selectedIndex = 0
                self.todoTitletxt.text = ""
                self.todoDetails.text = ""
                self.todoImg.image = nil
                
            }))
            
            present(alert, animated: true)
            
        }
        else {
            let alert = UIAlertController(title: "تعديل مهمة", message: "هل انت متاكد من تعديل المهمة", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "تعديل", style: .destructive, handler :{action in
                let todo = Todo(image : self.todoImg.image,title:self.todoTitletxt.text!, Date: currentDate,details: self.todoDetails.text)
                NotificationCenter.default.post(name: NSNotification.Name("TodoEdited"), object: nil, userInfo: ["TodoEditedIndex" :self.editedTodoIndex,"EditedTodo":todo])
                self.navigationController?.popViewController(animated: true)
            }))
                
            present(alert, animated: true)
                                         
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension NewTodoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true)
        todoImg.image = image
    }
    
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    
    }
    
    extension NewTodoVC {
        func getDate() -> String {
            let date = Date()
            let formatter = DateFormatter()
            formatter.timeZone = .current
            formatter.locale = .current
            formatter.dateFormat = "yyyy/MM/dd"
            let currentDate =  formatter.string(from: date)
            return currentDate
        }}
