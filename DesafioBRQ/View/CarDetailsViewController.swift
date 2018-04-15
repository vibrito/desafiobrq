//
//  CarDetailViewController.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 15/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit

class CarDetailsViewController: UIViewController
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollCar: UIScrollView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    
    var car: Car?
    var carId: Int?
    
    private let carDetailsPresenter = CarDetailsPresenter(carService: CarService())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        carDetailsPresenter.attachView(view: self)
        carDetailsPresenter.getCar(id: carId!)
    }
}

extension CarDetailsViewController: CarDetaislView
{
    func startLoading()
    {
        self.viewContainer.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func finishLoading()
    {
        activityIndicator.stopAnimating()
    }
    
    func showError()
    {
        self.viewContainer.isHidden = false
    }
    
    func setCar(car: Car)
    {
        self.car = car
        labelTitle.text = car.nome
        self.viewContainer.isHidden = false
    }
}
