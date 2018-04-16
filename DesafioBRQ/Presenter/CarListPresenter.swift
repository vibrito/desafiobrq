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
        carService.getCars { [weak self] arrayCars in
            self?.carListView?.finishLoading()
            if ((arrayCars) != nil)
            {
                self?.carListView?.setList(cars: arrayCars!)
            }
            else
            {
                self?.carListView?.showError()
            }
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
        
        DBManager.sharedInstance.addItem(object: item)
    }
}
