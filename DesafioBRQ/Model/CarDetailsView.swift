//
//  CarDetailView.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 15/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import Foundation

protocol CarDetaislView: NSObjectProtocol
{
    func startLoading()
    func finishLoading()
    func showError(message: String)
    func setCar(car: Car)
    func setBadge(badgeNumber: String?)
}
