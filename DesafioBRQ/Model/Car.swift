//
//  Car.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 14/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit
import ObjectMapper

class Car: Mappable
{
    var descricao: String?
    var id: Int?
    var imagem: String?
    var marca: String?
    var nome: String?
    var preco: Double?
    var quantidade: Int?
    
    required init?(map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        descricao   <- map["descricao"]
        id          <- map["id"]
        imagem      <- map["imagem"]
        marca       <- map["marca"]
        nome        <- map["nome"]
        preco       <- map["preco"]
        quantidade  <- map["quantidade"]
    }
}
