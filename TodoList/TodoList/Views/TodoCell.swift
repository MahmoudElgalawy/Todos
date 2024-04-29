//
//  TodoCell.swift
//  TodoList
//
//  Created by Mahmoud  on 08/03/2024.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var TodoDateLbl: UILabel!
    @IBOutlet weak var TodoTitleLbl: UILabel!
    @IBOutlet weak var TodoImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(image : UIImage,title: String,date: String  ){
        
        TodoTitleLbl.text = title
        TodoDateLbl.text = date
        TodoImg.image = image
        
    }
}

