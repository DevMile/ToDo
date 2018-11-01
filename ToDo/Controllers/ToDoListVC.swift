//
//  ViewController.swift
//  ToDo
//
//  Created by Milan Bojic on 10/30/18.
//  Copyright © 2018 Milan Bojic. All rights reserved.

// UITableViewController has all the delegates, protocols set by default

import UIKit
import CoreData

class ToDoListVC: UITableViewController {
    
    var itemArray = [Item]()
    // initialize CoreData context for working with data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //showing the path to files
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadData()
        
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
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //set checkmark when selected to opposite to ones before
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        saveItems()
    }
    //MARK: - Add Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (success) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation Methods
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error while encoding item array \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
    }
    
    
}

