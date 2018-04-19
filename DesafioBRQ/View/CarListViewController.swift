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
    @IBOutlet weak var buttonTry: UIButton!
    var barButtonCart: BadgeBarButtonItem!
    
    var arrayCars: [Car] = []
    var arrayTableView: [Car] = []
    let cellBuffer: CGFloat = 2
    let cellHeight: CGFloat = 100
    
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
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        barButtonCart.badgeText = nil
        carListPresenter.getBadgeNumber()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if  (segue.identifier == "segueDetails")
        {
            if let indexPath = sender as? IndexPath
            {
                let vc = segue.destination as! CarDetailsViewController
                let car = arrayTableView[indexPath.row]
                vc.carId = car.id
            }
        }
    }
    
    @IBAction func reload(_ sender: Any)
    {
        carListPresenter.getCars()
    }
    
    @objc func addItem(_ sender: Any)
    {
        let index = (sender as AnyObject).tag!
        carListPresenter.addToCart(car: arrayTableView[index])
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
        tableViewCar.isHidden = true
        buttonTry.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func finishLoading()
    {
        activityIndicator.stopAnimating()
    }
    
    func showError(message: String)
    {
        activityIndicator.stopAnimating()
        buttonTry.isHidden = false
        
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setList(cars: [Car])
    {
        arrayCars = cars
        arrayTableView = cars
        arrayTableView.append(contentsOf: arrayCars)
        tableViewCar.isHidden = false
        tableViewCar.reloadData()
    }
    
    func setBadge(badgeNumber: String?)
    {
        barButtonCart.badgeText = badgeNumber
    }
}

extension CarListViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let buffer: CGFloat = cellBuffer * cellHeight
        let scrollPosition = scrollView.contentOffset.y
        
        if scrollPosition > bottom - buffer
        {
            arrayTableView.append(contentsOf: arrayCars)
            tableViewCar.reloadData()
        }
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
        return arrayTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! CarCell
        let car = arrayTableView[indexPath.row]
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

