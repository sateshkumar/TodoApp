//
//  secondViewController.swift
//  TodoApp
//
//  Created by satesh kumar on 4/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData



class secondViewController: UITableViewController {
var categoryItems = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loaditem()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return categoryItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for : indexPath)
        
        let citem = categoryItems[indexPath.row]
        
        cell.textLabel?.text = citem.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToCategory", sender: self)
        
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination as! TodoListViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationvc.selectedCategory = categoryItems[indexpath.row]
        }
    }
    
    
    
    

    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var uitextFieldtext =  UITextField()
        
        let alert = UIAlertController(title: "addNewCategory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "addCategory", style: .default) { (Action) in
            
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = uitextFieldtext.text!
            
           self.categoryItems.append(newCategory)
            
            self.tableView.reloadData()
            
            self.save()
            
            
            
        }
        
        
        alert.addTextField { (TextField) in
            TextField.placeholder = "Add Category"
            
            uitextFieldtext = TextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    
        
     
        
    }
    
    func save() {
        do{
        try context.save()
        }
        catch{
            print("error while save category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loaditem(request : NSFetchRequest<Category> = Category.fetchRequest() ) {
        
        do {
        categoryItems = try context.fetch(request)
        
        }
        catch{
            print("error while load item \(error)" )
        }
        
    }
    
}
