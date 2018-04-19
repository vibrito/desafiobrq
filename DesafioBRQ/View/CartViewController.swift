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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        self.activityIndicator.startAnimating()
        self.tableViewCart.isHidden = true
    }
    
    func setList(array: Results<CartItem>!)
    {
        arrayCartItens = array
        self.activityIndicator.stopAnimating()
        self.tableViewCart.reloadData()
    }
    
    func removeProduct(id: Int)
    {
        self.tableViewCart.reloadData()
    }
    
    func removeAllProducts()
    {
        self.tableViewCart.reloadData()
    }
    
    func showError(message: String)
    {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAndDismiss(message: String)
    {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func finishCheckout()
    {
        //TODO: Adicionar alerta e remover os dados do array do carrinho
        self.activityIndicator.stopAnimating()
        self.tableViewCart.isHidden = false
    }
}

extension CartViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if  (indexPath.section == 0)
        {
            return 100
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        cartPresenter.checkout()
    }
}

extension CartViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0)
        {
            return arrayCartItens.count
        }
        else
        {
            if (arrayCartItens.count > 0)
            {
                return 1
            }
            
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (indexPath.section == 0)
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
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
}
