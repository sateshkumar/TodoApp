//
//  ViewController.swift
//  TodoApp
//
//  Created by satesh kumar on 4/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

import RealmSwift

class TodoListViewController: UITableViewController {

    
    let realm = try! Realm()
  
    var itemArray : Results<Item>?
    var selectedCategory  : Category? {
        didSet{
         loadItem()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        
        
//                if let items = defaults.array(forKey: "TodoArrayList") as? [Item] {
//            itemArray = items
//
        
  //  }
        
       
        
        
   // loadItem()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("called")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
       
        if  let item = itemArray?[indexPath.row]{
            
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        }else{
            cell.textLabel?.text = "no items added"
        }
       
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//
//
//        save()
//
        
        if let item = itemArray?[indexPath.row] {
            do{
            try realm.write {
                item.done = !item.done
            }
        }
            catch{
                
            }
        
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
   
    
    
    
    @IBAction func AdditemList(_ sender: UIBarButtonItem) {
        
        var UItextfield = UITextField()
        
        
        let alert = UIAlertController(title: "AddNewItem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "AddNewItem", style: .default) { (action) in
            
            if let currentCa = self.selectedCategory {
            
        
            
            do {
                try self.realm.write {
            
                    let newItem = Item()
                    newItem.title = UItextfield.text!
                    newItem.done = false
                    newItem.date =  Date()
                    currentCa.items.append(newItem)
            }
                
            }
            catch{
                print("error while saving items \(error)")
                
            }
            }
            self.tableView.reloadData()
            
            
                
            }
        
        
        alert.addTextField(configurationHandler: { (uiAlertTextField) in
        uiAlertTextField.placeholder = "Add New Items"
            
            UItextfield = uiAlertTextField
        })
        
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
    
    
    
    
    
    func loadItem(){
      //  let request : NSFetchRequest<Item> = Item.fetchRequest()

//        let capraticate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//
//        if let additionalpradicate = pradicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [capraticate , additionalpradicate])
//        }else{
//            request.predicate = capraticate
//        }
//
//
//
//
//        do{
//        itemArray = try context.fetch(request)
//
//        }catch{
//            print(error)
//        }
        
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        
        
        
        

        tableView.reloadData()



    }
    
    
    
}


extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
        
        
        
        


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






