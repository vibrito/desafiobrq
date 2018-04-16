//
//  CartViewController.swift
//  DesafioBRQ
//
//  Created by Vinicius Brito on 16/04/18.
//  Copyright © 2018 Vinicius Brito. All rights reserved.
//

import UIKit
import RealmSwift

class CartViewController: UIViewController
{
    @IBOutlet weak var tableViewCart: UITableView!
    
    private let cartPresenter = CartPresenter()
    var arrayCartItens : Results<CartItem>!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableViewCart.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        cartPresenter.attachView(view: self)
        cartPresenter.getCartList()
    }
    
    @objc func removeItem(_ sender: Any)
    {
        let index = (sender as AnyObject).tag!
        cartPresenter.removeItem(item: arrayCartItens[index])
    }
}

extension CartViewController: CartView
{    
    func startLoading()
    {
        self.tableViewCart.isHidden = true
    }
    
    func setList(array: Results<CartItem>!)
    {
        arrayCartItens = array
        self.tableViewCart.reloadData()
    }
    
    func removeProduct(id: Int)
    {
        //TODO: Colocar animação de retirada de apenas uma célula
        self.tableViewCart.reloadData()
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
        return arrayCartItens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! CarCell
        
        let item = arrayCartItens[indexPath.row]
        cell.selectionStyle = .none

        cell.labelTitle?.text = item.name
        cell.labelBrand?.text = item.brand
        let doubleStr = String(format: "%.2f", item.price)
        cell.labelPrice?.text = "R$ \(doubleStr)"

        let url = URL(string: item.image)!
        let placeholderImage = UIImage(named: "Placeholder")!
        cell.imageViewCar.af_setImage(withURL: url, placeholderImage: placeholderImage)
        
        cell.buttonBuy.setTitle("Remover do carrinho", for: .normal)
        cell.buttonBuy.tag = indexPath.row
        cell.buttonBuy.addTarget(self, action: #selector(removeItem(_:)), for: .touchUpInside)
        
        return cell
    }
}
