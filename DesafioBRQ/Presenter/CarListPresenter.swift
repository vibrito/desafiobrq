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
}
