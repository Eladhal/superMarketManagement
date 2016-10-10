//
//  Products List.swift
//  SuperAmit
//
//  Created by elad halperin on 7/12/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Products_List: UIViewController,ProductListProtocol,UITableViewDataSource,UITableViewDelegate
{
    
    var section:String!
    
    let cell : Product_List_Cell = Product_List_Cell()
    
    var arrayOfProducts:[Product] = [] // list of products from a specific section...
    var listOfProducts = ListOfProducts()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        arrayOfProducts=listOfProducts.totalList[section]!
    }
    override func viewWillAppear(animated: Bool){
        tableView.reloadData()
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfProducts.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! Product_List_Cell
        cell.delegate = self
        cell.CellImage.image = UIImage(named: arrayOfProducts[indexPath.row].imageName)
        cell.TopicLabel.text = arrayOfProducts[indexPath.row].name
        cell.PriceLabel.text = String(arrayOfProducts[indexPath.row].cost)
        cell.quantityText.text = String(arrayOfProducts[indexPath.row].quantity)
        //Design
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.blackColor().CGColor
        return cell
    }
    
    func btnPlusTapped(sender: Product_List_Cell) { // button to enlarge products and to calculate cost
        let indexPath = tableView.indexPathForCell(sender)
        if let sender1 = sender.quantityText.text {
            var quantity = Int(sender1)!
            quantity = quantity+1
            arrayOfProducts[indexPath!.row].quantity=quantity
            sender.quantityText.text = String(quantity)
            if let price = sender.PriceLabel.text {
                var sum = Double(quantity) * arrayOfProducts[indexPath!.row].cost
                sender.PriceLabel.text = String(sum)
            }
        }
        
    }
    func btnMinusTapped(sender: Product_List_Cell) { // button to reduce products and to calculate cost
        let indexPath = tableView.indexPathForCell(sender)
        if let sender1 = sender.quantityText.text {
            var quantity = Int(sender1)!
            switch quantity{
            case 0:
                return
            case 1:
                quantity = quantity-1
                arrayOfProducts[indexPath!.row].quantity=quantity
                sender.quantityText.text = String(quantity)
            default:
                quantity = quantity-1
                arrayOfProducts[indexPath!.row].quantity=quantity
                sender.quantityText.text = String(quantity)
                if let price = sender.PriceLabel.text {
                    var sum = Double(quantity) * arrayOfProducts[indexPath!.row].cost
                    sender.PriceLabel.text = String(sum)
                }
            }
        }
    }
    
    @IBAction func btnAddToCart(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ShoppingList") as! Shopping_List_Before_Payment
        vc.listOfProducts = self.listOfProducts
        //listOfProducts.totalList[section] = arrayOfProducts
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

}
