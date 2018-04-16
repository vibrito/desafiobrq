//
//  CartView.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 16/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import Foundation
import RealmSwift

protocol CartView: NSObjectProtocol
{
    func startLoading()
    func setList(array: Results<CartItem>!)
    func removeProduct(id: Int)
    func removeAllProducts()
    func showError()
    func checkout()
}
