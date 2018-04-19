//
//  DBManager.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 16/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager
{
    private var   database:Realm
    static let   sharedInstance = DBManager()

    private init()
    {
        database = try! Realm()
    }
    
    func getCartItens() ->   Results<CartItem>
    {
        let results = database.objects(CartItem.self).filter("quantity > 0")        
        return results
    }
    
    func getTotalValue() -> Double
    {
        var double: Double = 0.0
        let results = database.objects(CartItem.self).filter("quantity > 0") 
        for item in results
        {
           double = double + item.price
        }
        
        return double
    }
    
    func addItem(object: CartItem)
    {
        try! database.write
        {
            database.add(object, update: true)
        }
    }
    
    func deleteItem(object: CartItem)
    {
        try!   database.write
        {
            object.quantity = 0
            database.add(object, update: true)
        }
    }
    
    func deleteAllItens()
    {
        try!   database.write
        {
            database.deleteAll()
        }
    }
}
