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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    @IBOutlet weak var itemText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
        
//        if let items = defaults.array(forKey: "IllistriousArray") as? [String] {
//
//        }
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
        saveItems()
      
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
            
            self.saveItems()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Item Name"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Model Manipulation Methods
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print("Error encoding itemsArray, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems() {
        
      
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemsArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error decoding itemsArray, \(error)")
            }
        }
    }
}



