//
//  ListCarView.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 14/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import Foundation

protocol CarListView: NSObjectProtocol
{
    func startLoading()
    func finishLoading()
    func showError()
    func setList(cars: [Car])
    func setBadge(badgeNumber: String)
}
