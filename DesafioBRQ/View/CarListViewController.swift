//
//  ViewController.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 14/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import AlamofireImage

class CarListViewController: UIViewController
{
    @IBOutlet weak var tableViewCar: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var barButtonCart: BadgeBarButtonItem!
    
    var arrayCars: [Car] = []
    
    private let carListPresenter = CarListPresenter(carService: CarService())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        barButtonCart = BadgeBarButtonItem(image: "Cart", target: self, action: #selector(callCart))!
        navigationItem.rightBarButtonItem = barButtonCart
        
        tableViewCar.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        carListPresenter.attachView(view: self)
        carListPresenter.getCars()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        carListPresenter.getBadgeNumber()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if  (segue.identifier == "segueDetails")
        {
            if let indexPath = sender as? IndexPath
            {
                let vc = segue.destination as! CarDetailsViewController
                let car = arrayCars[indexPath.row]
                vc.carId = car.id
            }
        }
    }
    
    @objc func addItem(_ sender: Any)
    {
        let index = (sender as AnyObject).tag!
        carListPresenter.addToCart(car: arrayCars[index])
    }
    
    @objc func callCart()
    {
        performSegue(withIdentifier: "segueCart", sender: nil)
    }
}

extension CarListViewController: CarListView
{
    func startLoading()
    {
        self.tableViewCar.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func finishLoading()
    {
        activityIndicator.stopAnimating()
    }
    
    func showError()
    {
        activityIndicator.stopAnimating()
        self.tableViewCar.isHidden = true
    }
    
    func setList(cars: [Car])
    {
        arrayCars = cars
        self.tableViewCar.isHidden = false
        self.tableViewCar.reloadData()
    }
    
    func setBadge(badgeNumber: String)
    {
        barButtonCart.badgeText = badgeNumber
    }
}

extension CarListViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "segueDetails", sender: indexPath)
    }
}

extension CarListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! CarCell
        let car = arrayCars[indexPath.row]
        cell.selectionStyle = .none
        
        cell.labelTitle?.text = car.nome
        cell.labelBrand?.text = car.marca
        let doubleStr = String(format: "%.2f", car.preco ?? 0)
        cell.labelPrice?.text = "R$ \(doubleStr)"
        
        let url = URL(string: car.imagem!)!
        let placeholderImage = UIImage(named: "Placeholder")!
        cell.imageViewCar.af_setImage(withURL: url, placeholderImage: placeholderImage)
        
        cell.buttonBuy.tag = indexPath.row
        cell.buttonBuy.addTarget(self, action: #selector(addItem(_:)), for: .touchUpInside)
                
        return cell
    }
}

