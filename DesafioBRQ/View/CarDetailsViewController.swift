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
    var barButtonCart: BadgeBarButtonItem!

    var car: Car?
    var carId: Int?
    
    private let carDetailsPresenter = CarDetailsPresenter(carService: CarService())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        carDetailsPresenter.attachView(view: self)
        carDetailsPresenter.getCar(id: carId!)
        
        barButtonCart = BadgeBarButtonItem(image: "Cart", target: self, action: #selector(callCart))!
        navigationItem.rightBarButtonItem = barButtonCart
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        barButtonCart.badgeText = nil
        carDetailsPresenter.getBadgeNumber()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    @IBAction func addToCart(_ sender: Any)
    {
        carDetailsPresenter.addToCart(car: car!)
    }
    
    @objc func callCart()
    {
        performSegue(withIdentifier: "segueCart", sender: nil)
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
    
    func showError(message: String)
    {
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAndDismiss(message: String)
    {
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
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
    
    func setBadge(badgeNumber: String?)
    {        
        barButtonCart.badgeText = badgeNumber
    }
}
