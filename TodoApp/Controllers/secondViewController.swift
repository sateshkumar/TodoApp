//
//  secondViewController.swift
//  TodoApp
//
//  Created by satesh kumar on 4/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RealmSwift



class secondViewController: UITableViewController {

    let realm = try! Realm()
    
    var category : Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loaditem()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return category?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for : indexPath)
        
       
        
        cell.textLabel?.text = category?[indexPath.row].name ??  "no categories added"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToCategory", sender: self)
        
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination as! TodoListViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationvc.selectedCategory = category?[indexpath.row]
        }
    }
    
    
    
    

    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var uitextFieldtext =  UITextField()
        
        let alert = UIAlertController(title: "addNewCategory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "addCategory", style: .default) { (Action) in
            
            
            let newCategory = Category()
            
            newCategory.name = uitextFieldtext.text!
//
//           self.category.append(newCategory)
            
            self.tableView.reloadData()
            
            self.save(category: newCategory)
            
            
            
        }
        
        
        alert.addTextField { (TextField) in
            TextField.placeholder = "Add Category"
            
            uitextFieldtext = TextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    
        
     
        
    }
    
    func save(category : Category) {
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("error while save category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loaditem() {
        
        category = realm.objects(Category.self)
        
     
        tableView.reloadData()
    }
    
}
