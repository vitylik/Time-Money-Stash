//
//  ViewController.swift
//  toDoList1
//
//  Created by macbook on 06.12.2023.
//

import UIKit

    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoCellDelegate {
        
        var todos: [ToDo] = [ToDo(title: "Welcome to the club body!", completed: false)]
        
        @IBOutlet weak var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            loadForPersisteseStore()
            // Do any additional setup after loading the view.
        }
        
        @IBAction func addToDo(_ sender: Any) {
            let alert = UIAlertController(title: "Create To-Do", message: " ", preferredStyle: .alert)
            alert.addTextField()
            let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
                if let textName = alert.textFields?.first?.text { self.todos.append(ToDo(title: textName, completed: false))
                    self.tableView.reloadData()
                    self.saveToPersisteseStore()
                }
            }
            
            alert.addAction(saveButton)
            let cancelButton = UIAlertAction(title: "Delete", style: .destructive)
            alert.addAction(cancelButton)
            
            present(alert, animated: true)
        }
        
        //MARK: - Table View Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            saveToPersisteseStore()
            return todos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
            let toDoCell = todos[indexPath.row]
            cell.delegate = self
            cell.updateCell(with: toDoCell)
            saveToPersisteseStore()
            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                todos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                saveToPersisteseStore()
            }
        }
        
        func cellTapped(cell: ToDoTableViewCell) {
            guard let index = tableView.indexPath(for: cell)
            else { return }
            let todo = todos[index.row]
            todo.completed.toggle()
            tableView.reloadData()
            saveToPersisteseStore()
        }
        
        //MARK: - Persistence
        
        func createPersistenseStore() -> URL {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileURL = url[0].appendingPathComponent("ToDoList.json")
            return fileURL
        }
        
        func saveToPersisteseStore() {
            do {
                let data = try JSONEncoder().encode(todos)
                try data.write(to: createPersistenseStore())
            } catch {
                print("Error while saving")
            }
        }
        
        func loadForPersisteseStore() {
            do {
                let data = try Data(contentsOf: createPersistenseStore())
                todos = try JSONDecoder().decode([ToDo].self, from: data)
            } catch {
                print("Error while saving")
        }
    }
}
