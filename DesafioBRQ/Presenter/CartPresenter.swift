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
        self.cartView?.startLoading()
        
        let results = DBManager.sharedInstance.getCartItens()
        self.cartView?.setList(array: results)
        
        if results.count == 0
        {
            self.cartView?.showAlert(title: nil, message: "Seu carrinho está vazio.", dismiss: true)
        }
    }
        
    func removeItem(item: CartItem)
    {
        DBManager.sharedInstance.deleteItem(object: item)
        getCartList()
    }
    
    func checkout()
    {
        self.cartView?.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DBManager.sharedInstance.deleteAllItens()
            self.cartView?.showAlert(title: "Sucesso", message: "Compra efetuada com sucesso!", dismiss: true)
            self.cartView?.finishCheckout()
        }
    }
}
