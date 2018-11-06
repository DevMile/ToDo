//
//  Category.swift
//  ToDo
//
//  Created by Milan Bojic on 11/6/18.
//  Copyright © 2018 Milan Bojic. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
