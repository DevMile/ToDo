//
//  ViewController.swift
//  ToDo
//
//  Created by Milan Bojic on 10/30/18.
//  Copyright © 2018 Milan Bojic. All rights reserved.

// UITableViewController has all the delegates, protocols set by default

import UIKit

class ToDoListVC: UITableViewController {
    
    var itemArray = ["Some cell", "Another text", "Third word"]
    var defaults = UserDefaults.standard //initiating UserDefaults database
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // showing saved itemArray from UserDefaults database in current VC
        if let items = defaults.array(forKey: "toDoListArray") as? [String] {
            itemArray = items
        }
        
    }
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //adds nice selection effect
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    //MARK: - Add Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add ToDo Item", message: "samo testiram", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (success) in
            guard let itemName = textField.text else {return}
            self.itemArray.append(itemName)
            self.defaults.set(self.itemArray, forKey: "toDoListArray") // saving itemArray in UserDefaults database
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

