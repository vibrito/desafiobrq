//
//  CartItem.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 16/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit
import RealmSwift

class CartItem: Object
{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var createdAt = NSDate()
    @objc dynamic var brand = ""
    @objc dynamic var image = ""
    @objc dynamic var price = 0.0
    @objc dynamic var quantity = 0
    
    override class func primaryKey() -> String?
    {
        return "id"
    }
}
