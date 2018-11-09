//
//  CategoryVC.swift
//  ToDo
//
//  Created by Milan Bojic on 11/5/18.
//  Copyright © 2018 Milan Bojic. All rights reserved.


import UIKit
import RealmSwift
import ChameleonFramework

// TODO: - Add tap gesture recognizer for Add actions

class CategoryVC: SwipeCellVC {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    var colors = [FlatYellow(), FlatSkyBlue(), FlatLime(), FlatMint(), FlatPink(), FlatSand(), FlatGreen(), FlatOrange(), FlatPurple(), FlatPowderBlue()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 80.0
    }
    
    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
            guard let categoryColour = UIColor(hexString: category.cellColor) else {fatalError()}
            cell.backgroundColor = categoryColour
            cell.textLabel?.text = category.name
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItemList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    // MARK: - Add Category
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add ToDo Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (success) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.cellColor = self.colors.randomElement()?.hexValue() ?? "FEFFA0"
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new ToDo category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Could not delete Category \(error)")
            }
        }
    }
}
