//
//  Category.swift
//  TodoApp
//
//  Created by satesh kumar on 4/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import RealmSwift



class Category: Object{
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
