//
//  CarDetailViewController.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 15/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit
import RealmSwift

class CarDetailsViewController: UIViewController
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollCar: UIScrollView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageViewCar: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    
    var car: Car?
    var carId: Int?
    
    private let carDetailsPresenter = CarDetailsPresenter(carService: CarService())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        carDetailsPresenter.attachView(view: self)
        carDetailsPresenter.getCar(id: carId!)
    }
    
    @IBAction func addToCart(_ sender: Any)
    {
        carDetailsPresenter.addToCart(car: car!)
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
        self.viewContainer.isHidden = true
    }
    
    func setCar(car: Car)
    {
        self.car = car
        self.title = car.nome
        labelDescription.text = car.descricao
        let url = URL(string: car.imagem!)!
        let placeholderImage = UIImage(named: "Placeholder")!
        imageViewCar.af_setImage(withURL: url, placeholderImage: placeholderImage)
        
        labelBrand.text = "Fabricante: \(car.marca!)"
        let doubleStr = String(format: "%.2f", car.preco ?? 0)
        labelPrice.text = "R$ \(doubleStr)"
        
        self.viewContainer.isHidden = false
    }
}
