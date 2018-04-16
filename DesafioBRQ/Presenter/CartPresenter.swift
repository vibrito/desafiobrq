//
//  CartPresenter.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 16/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import Foundation

class CartPresenter
{
    weak private var cartView: CartView?

    init()
    {
        
    }
    
    func attachView(view: CartView)
    {
        cartView = view
    }
    
    func detachView()
    {
        cartView = nil
    }
    
    func getCartList()
    {
        self.cartView?.setList(array: DBManager.sharedInstance.getCartItens())
    }
    
    func removeItem(item: CartItem)
    {
        DBManager.sharedInstance.deleteItem(object: item)
        self.cartView?.setList(array: DBManager.sharedInstance.getCartItens())

        //TODO: Usar esse método
        //self.cartView?.removeProduct(id: item.id)
    }
}
