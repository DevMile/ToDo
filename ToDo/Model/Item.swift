//
//  Item.swift
//  ToDo
//
//  Created by Milan Bojic on 11/6/18.
//  Copyright © 2018 Milan Bojic. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
