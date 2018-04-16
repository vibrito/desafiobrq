//
//  CartViewController.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 16/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit

class CartViewController: UIViewController
{
    @IBOutlet weak var tableViewCart: UITableView!
    
    private let cartPresenter = CartPresenter()
    
    //TODO: Apagar esse array, será salvo localmente
    var arrayCars: [Car] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableViewCart.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        cartPresenter.attachView(view: self)
        cartPresenter.getCartList()
    }
}

extension CartViewController: CartView
{    
    func startLoading()
    {
        self.tableViewCart.isHidden = true
    }
    
    func setList()
    {
        self.tableViewCart.reloadData()
    }
    
    func removeProduct(id: String)
    {
        
    }
    
    func removeAllProducts()
    {
        
    }
    
    func showError()
    {
        
    }
    
    func checkout()
    {
        
    }
}

extension CartViewController: UITableViewDataSource
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
        
        cell.buttonBuy.setTitle("Remover do carrinho", for: .normal)
        return cell
    }
}
