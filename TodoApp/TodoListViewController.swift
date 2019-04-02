//
//  ViewController.swift
//  TodoApp
//
//  Created by satesh kumar on 4/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray  = ["Banna", "Apple" , "Oranges"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
   
    
    
    
    @IBAction func AdditemList(_ sender: UIBarButtonItem) {
        
        var UItextfield = UITextField()
        
        
        let alert = UIAlertController(title: "AddNewItem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "AddNewItem", style: .default) { (action) in
            
            print(UItextfield.text!)
            
            
                
            }
        
        
        alert.addTextField(configurationHandler: { (uiAlertTextField) in
        uiAlertTextField.placeholder = "Add New Items"
            
            UItextfield = uiAlertTextField
        })
        
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
}
    
    
    

    


