//
//  IllistriousViewController.swift
//  Illistrious
//
//  Created by Eden on 6/28/18.
//  Copyright © 2018 Eden Mugg. All rights reserved.
//

import UIKit

class IllistriousViewController: UITableViewController {
    
    var itemsArray = [Item]()
    let defaults = UserDefaults.standard

    @IBOutlet weak var itemText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "item1"
        itemsArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "item2"
        itemsArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "item3"
        itemsArray.append(newItem3)
        
        if let items = defaults.array(forKey: "IllistriousArray") as? [String] {
           
        }
    }

    //MARK: Create datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsArray.count
        
    }
    
    //MARK: Create delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: Add new items to list
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New List Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //When user clicks the "Add Item" button on the UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemsArray.append(newItem)
            self.defaults.set(self.itemsArray, forKey: "IllistriousArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Item Name"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

