//
//  CarService.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 14/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CarService
{
    func getCars(callback: @escaping ([Car]?) -> ()) -> Void
    {
        let URL = "http://desafiobrq.herokuapp.com/v1/carro/"
        Alamofire.request(URL).responseArray { (response: DataResponse<[Car]>) in
            let result = response.result.value
            callback(result)
        }
    }
    
    func getCar(carId: String, callback: @escaping (Car?) -> ()) -> Void
    {
        let URL = "http://desafiobrq.herokuapp.com/v1/carro/\(carId)"
        Alamofire.request(URL).responseObject { (response: DataResponse<Car>) in
            let result = response.result.value
            callback(result)
        }
    }
}
