//
//  ViewController.swift
//  TodoApp
//
//  Created by satesh kumar on 4/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {

    var itemArray  = [Item]()
    var selectedCategory  : Category? {
        didSet{
            loadItem()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        
        
//                if let items = defaults.array(forKey: "TodoArrayList") as? [Item] {
//            itemArray = items
//
        
  //  }
        
       
        
        
    loadItem()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("called")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
            
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
       
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        save()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
   
    
    
    
    @IBAction func AdditemList(_ sender: UIBarButtonItem) {
        
        var UItextfield = UITextField()
        
        
        let alert = UIAlertController(title: "AddNewItem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "AddNewItem", style: .default) { (action) in
            
           
            let newItem = Item(context: self.context)
            newItem.title = UItextfield.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)

//
          
            
            self.tableView.reloadData()
            
            self.save()
            
                
            }
        
        
        alert.addTextField(configurationHandler: { (uiAlertTextField) in
        uiAlertTextField.placeholder = "Add New Items"
            
            UItextfield = uiAlertTextField
        })
        
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
    
    
    
    
    func save() {

        do{
          try  context.save()
            
        }catch{
            print("error saving contact")
        }
        
        tableView.reloadData()
    }
    
    
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest() , pradicate : NSPredicate? = nil){
      //  let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let capraticate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        
        if let additionalpradicate = pradicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [capraticate , additionalpradicate])
        }else{
            request.predicate = capraticate
        }
        
        
        
        
//        let compoundPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [capraticate , pradicate])
//
//        request.predicate = capraticate
//
        do{
        itemArray = try context.fetch(request)
            
        }catch{
            print(error)
        }
        
        tableView.reloadData()
        
        
        
    }
    
    
    
}


extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
       let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors  = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItem(with: request)
        
        do{
       
            try   itemArray = context.fetch(request)
            
        }
        catch {
            print("error while sort the items \(error)")
        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
}
    
    

    


