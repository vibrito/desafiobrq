//
//  CarDetailsPresenter.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 15/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import Foundation

class CarDetailsPresenter
{
    private let carService: CarService
    weak private var carDetailsView: CarDetaislView?
    
    init(carService: CarService)
    {
        self.carService = carService
    }
    
    func attachView(view: CarDetaislView)
    {
        carDetailsView = view
    }
    
    func detachView()
    {
        carDetailsView = nil
    }
    
    func getCar(id: Int)
    {
        self.carDetailsView?.startLoading()
        let carId = String(id)
        
        carService.getCar(carId: carId) { (car) in
            if ((car) != nil)
            {
                self.carDetailsView?.setCar(car: car!)
            }
            else
            {
                self.carDetailsView?.showError()
            }
        }
    }
}
