//
//  Last invitation.swift
//  SuperAmit
//
//  Created by elad halperin on 7/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class Last_invitation: UIViewController,UITableViewDataSource,UITableViewDelegate,Last_invitation_protocol {
    
    var listOfProducts = ListOfProducts()
    var arrayOfSections:[String]=[]
    var item = Product()
    var arrayOfProducts=[Product]()
    var listOfShopping : [String:[Product]]=[:]
    var ref:FIRDatabaseReference!
    var sumOfShopingCost:Double = 0.0
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalPaymentLabel: UILabel!
    
    override func viewDidLoad() {
        let userID:String = (FIRAuth.auth()?.currentUser?.uid)!
        ref = FIRDatabase.database().reference().child(userID).child("Shopping cart")
        ref.observeEventType(FIRDataEventType.Value,withBlock: { (snapshot) in
            if let productList = snapshot.value as? [String:AnyObject]{
            
            for (section,products) in productList{ // Retrieve products from fiberBase to listOfShopping
                for product in products as! NSDictionary{
                    let dic:[String:AnyObject] = product.value as! [String : AnyObject]
                    for (key,value) in dic{
                        switch key{
                            case "cost": self.item.cost = value as! Double
                            case "image": self.item.imageName = value as! String
                            case "quantity": self.item.quantity = value as! Int
                            case "name": self.item.name = value as! String
                        default: return
                        }
                    }
                        self.arrayOfProducts.append(self.item)
                        self.item = Product()

                }
                self.listOfShopping[section]=self.arrayOfProducts
                self.arrayOfProducts = [Product]()
              }
            self.arrayOfSections = [String](self.listOfShopping.keys)
            for (_,products) in self.listOfShopping{
                for product in products{
                    self.sumOfShopingCost = self.sumOfShopingCost+product.cost * Double(product.quantity)
                }
            }
            self.totalPaymentLabel.text = "Total Payment"+"   "+"\(self.sumOfShopingCost)"
            self.totalPaymentLabel.layer.borderWidth=1.5
            self.totalPaymentLabel.layer.borderColor=UIColor.greenColor().CGColor
            self.updateListOfProducts(self.listOfShopping) // call a function to update listOfProducts
                
            dispatch_async(dispatch_get_main_queue(), {self.tableView.reloadData()
            })
            }
        })

    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayOfSections.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayOfSections[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfShopping[arrayOfSections[section] ]!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionName = arrayOfSections[indexPath.section]
        let arrayOfProducts = listOfShopping[sectionName]
        let cell = tableView.dequeueReusableCellWithIdentifier("LastInvitationCell") as! Last_invitation_cell
        cell.delegate = self
        cell.imageShopListCell.image = UIImage(named: arrayOfProducts![indexPath.row].imageName)
        cell.tilteShopListCell.text = String(arrayOfProducts![indexPath.row].quantity) + " " + arrayOfProducts![indexPath.row].name
        cell.priceShopListCell.text = String(arrayOfProducts![indexPath.row].cost * Double(arrayOfProducts![indexPath.row].quantity))+"$"
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        return cell
        
    }
    
    func btnRemoveProductTapped(sender: Last_invitation_cell) {
        let indexPath = tableView.indexPathForCell(sender)
        let secName = arrayOfSections[(indexPath?.section)!]
        var tempArray = listOfShopping[secName]
        sumOfShopingCost = sumOfShopingCost - Double(tempArray![indexPath!.row].quantity) * tempArray![indexPath!.row].cost
        tempArray![indexPath!.row].quantity=0
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
    
    func updateListOfProducts(listOfShopping : [String:[Product]]) {
        for (_,products) in listOfShopping{
            for product in products{
                if product.quantity>0{
                    for (_,productslistOfProducts) in listOfProducts.totalList{
                        for productListOfProduct in productslistOfProducts{
                            if productListOfProduct.name == product.name{
                                productListOfProduct.quantity = product.quantity
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier!{
            case "segAddProducts":
                let vc = segue.destinationViewController as! Buying_online
                vc.listOfProducts=self.listOfProducts
            case "segPayment":
                let vc = segue.destinationViewController as! Payment
                vc.listOfShopping = self.listOfShopping
            default:
                return
            }
        
    }
    

}
