//
//  Shopping List Before Payment.swift
//  SuperAmit
//
//  Created by elad halperin on 7/16/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class Shopping_List_Before_Payment: UIViewController,UITableViewDataSource,UITableViewDelegate,Shoping_List_Protocol {
    var listOfProducts = ListOfProducts()
    var arrayOfSections:[String]=[]
    var listOfShopping : [String:[Product]]=[:] // dictionary of products that the client chose to buy
    var sumOfShopingCost:Double = 0.0
    var ref:FIRDatabaseReference!
    var alert:UIAlertView?
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    
    override func viewDidLoad() {
        var tempArray=[Product]()
        var flag:Bool
        for (section,products) in listOfProducts.totalList{ // Loop to find the products that the client  chose to buy (quantity > 0)
            flag = false
            for product in products {
                if product.quantity>0{
                    flag = true
                    tempArray.append(product)
                    sumOfShopingCost = sumOfShopingCost + product.cost * Double(product.quantity) // Calculate the total buy payment
                }
            }
            if flag == true{
                arrayOfSections.append(section)
            }
            listOfShopping[section]=tempArray
            tempArray=[Product]()
        }
        totalPaymentLabel.text = "Total Payment"+"   "+"\(sumOfShopingCost)"
        totalPaymentLabel.layer.borderWidth=1.5
        totalPaymentLabel.layer.borderColor=UIColor.greenColor().CGColor
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayOfSections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayOfSections[section]
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        var title = UILabel()
        title.font = UIFont(name: "Helvetica Neue", size: 25)!
        //title.textColor = UIColor.lightGrayColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfShopping[String(arrayOfSections[section])]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionName = arrayOfSections[indexPath.section]
        let arrayOfProducts = listOfShopping[sectionName]
        let cell = tableView.dequeueReusableCellWithIdentifier("shoppingCell") as! Shopping_List_cell
        cell.delegate = self
        cell.imageShopListCell.image = UIImage(named: arrayOfProducts![indexPath.row].imageName)
        cell.tilteShopListCell.text = String(arrayOfProducts![indexPath.row].quantity) + " " + arrayOfProducts![indexPath.row].name
        cell.priceShopListCell.text = String(arrayOfProducts![indexPath.row].cost * Double(arrayOfProducts![indexPath.row].quantity))+"$"
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        return cell
        
    }
    func btnRemoveProductTapped(sender: Shopping_List_cell) {
        let indexPath = tableView.indexPathForCell(sender)
        let secName = arrayOfSections[(indexPath?.section)!]
        var tempArray = listOfShopping[secName]
        sumOfShopingCost = sumOfShopingCost - Double(tempArray![indexPath!.row].quantity) * tempArray![indexPath!.row].cost
        tempArray![indexPath!.row].quantity=0
        nullifyProductQuantity(tempArray![indexPath!.row].name,section:secName) // update the main Data "listOfProducts"
        tempArray?.removeAtIndex(indexPath!.row)
        listOfShopping[secName]=tempArray // update "ListOfShopping" (The Source array of the tableView) after deleting row in tempArray
        tableView.deleteRowsAtIndexPaths([NSIndexPath.init(forRow: indexPath!.row, inSection: (indexPath?.section)!)], withRowAnimation: UITableViewRowAnimation.Automatic)
        if sumOfShopingCost<0.01{ 
            totalPaymentLabel.text = "Total Payment"+"   "+"0.0"
        }
        else{
        totalPaymentLabel.text = "Total Payment"+"   "+"\(sumOfShopingCost)"
        }
        
        tableView.reloadData()

    }
    
    func nullifyProductQuantity(name:String,section:String){ // update the main Data "listOfProducts"
        
        for productName in listOfProducts.totalList[section]!
        {
            if productName.name == name
            {
                productName.quantity = 0
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool { // Prevent segue in case of an empty shopping cart
        if sumOfShopingCost < 0.001 {
            self.alert = UIAlertView(title: "Notice", message: "The shopping cart is empty!", delegate: self, cancelButtonTitle: "OK")
            self.alert?.show()
            return false
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! Payment
        vc.listOfShopping = self.listOfShopping
    }
    
    
    
    
    

}
