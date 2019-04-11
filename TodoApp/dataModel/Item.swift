//
//  Item.swift
//  TodoApp
//
//  Created by satesh kumar on 4/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date?
    
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
