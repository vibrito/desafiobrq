//
//  CartView.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 16/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import Foundation

protocol CartView: NSObjectProtocol
{
    func startLoading()
    func setList()
    func removeProduct(id: String)
    func removeAllProducts()
    func showError()
    func checkout()
}
