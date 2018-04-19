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
        let results = DBManager.sharedInstance.getCartItens()
        self.cartView?.setList(array: results)
        
        if results.count == 0
        {
            self.cartView?.showErrorAndDismiss(message: "Seu carrinho está vazio.")
        }
    }
    
    func refresh()
    {
        
    }
    
    func removeItem(item: CartItem)
    {
        DBManager.sharedInstance.deleteItem(object: item)
        getCartList()
    }
    
    func checkout()
    {
        self.cartView?.startLoading()
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.cartView?.finishCheckout()
        }
    }
}
