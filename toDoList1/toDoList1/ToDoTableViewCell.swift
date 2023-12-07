//
//  ToDoTableViewCell.swift
//  toDoList1
//
//  Created by macbook on 06.12.2023.
//

import Foundation
import UIKit

protocol ToDoCellDelegate: AnyObject {
    func cellTapped(cell: ToDoTableViewCell)
}

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var toDoButton: UIButton!
    
    weak var delegate: ToDoCellDelegate?
    
    @IBAction func toDoButtonTapped(_ sender: Any) {
        delegate?.cellTapped(cell: self)
    }
    func updateCell(with todo: ToDo) {
        toDoLabel.text = todo.title
        toDoButton.setImage(UIImage(systemName: todo.completed ? "checkmark.circle" : "circle"), for: .normal)
    }
}
