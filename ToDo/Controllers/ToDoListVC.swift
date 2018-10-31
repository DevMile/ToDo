//
//  ViewController.swift
//  ToDo
//
//  Created by Milan Bojic on 10/30/18.
//  Copyright © 2018 Milan Bojic. All rights reserved.

// UITableViewController has all the delegates, protocols set by default

import UIKit

class ToDoListVC: UITableViewController {
    
    var itemArray = [Item]()
    var defaults = UserDefaults.standard //initiating UserDefaults database
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item()
        item1.title = "Mile"
        item1.done = true
        itemArray.append(item1)
        let item2 = Item()
        item2.title = "Shiki"
        item2.done = false
        itemArray.append(item2)
        let item3 = Item()
        item3.title = "Mina"
        item3.done = false
        itemArray.append(item3)
        
        //showing saved itemArray from UserDefaults database in current VC
        if let items = defaults.array(forKey: "toDoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //adds nice selection effect
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //sets done state when selected to opposite to ones before
        tableView.reloadData()
    }
    //MARK: - Add Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (success) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
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

