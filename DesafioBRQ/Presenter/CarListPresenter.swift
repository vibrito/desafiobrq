//
//  CarListPresenter.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 14/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import Foundation

class CarListPresenter
{
    private let carService: CarService
    weak private var carListView: CarListView?
    
    init(carService: CarService)
    {
        self.carService = carService
    }
    
    func attachView(view: CarListView)
    {
        carListView = view
    }
    
    func detachView()
    {
        carListView = nil
    }
    
    func getCars()
    {
        self.carListView?.startLoading()

        if Reachability.isConnectedToNetwork()
        {
            carService.getCars { [weak self] arrayCars in
                self?.carListView?.finishLoading()
                if ((arrayCars) != nil)
                {
                    self?.carListView?.setList(cars: arrayCars!)
                }
                else
                {
                    self?.carListView?.showError(message: "Erro na obtenção dos dados.")
                }
            }
        }
        else
        {
            self.carListView?.showError(message: "Sem acesso a internet, reconecte e tente novamente.")
        }
    }
    
    func addToCart(car: Car)
    {
        let item = CartItem()
        item.name = car.nome!
        item.id = car.id!
        item.createdAt = NSDate()
        item.brand = car.marca!
        item.image = car.imagem!
        item.price = car.preco!
        item.quantity = 1
        print("name of car: \(item.name)")
        
        let newTotal = DBManager.sharedInstance.getTotalValue() + item.price
        if (newTotal > 100000.00)
        {
            self.carListView?.showError(message: "Seu carrinho não pode conter mais de R$ 100000,00. Finalize sua compra ou retire itens do seu carrinho.")
        }
        else
        {
            DBManager.sharedInstance.addItem(object: item)
        }
        
        getBadgeNumber()
    }
    
    func getBadgeNumber()
    {
        let badgeNumber = String(DBManager.sharedInstance.getCartItens().count)
        
        if  badgeNumber == "0"
        {
            self.carListView?.setBadge(badgeNumber: "")
            return
        }
        
        self.carListView?.setBadge(badgeNumber: badgeNumber)
    }
}
