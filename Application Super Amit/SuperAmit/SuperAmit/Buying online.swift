//
//  Buing online.swift
//  SuperAmit
//
//  Created by elad halperin on 7/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//
import UIKit

class Buying_online: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    let cartImage=UIImage(named: "SuperMarket Cart")
    
    let imagesArray = [UIImage(named:"Vegetables")!,UIImage(named:"Fruits")!,UIImage(named:"Dairy")!,UIImage(named:"Candy")!,UIImage(named:"Meat")!,UIImage(named:"Cleaning")!,UIImage(named:"Drinks")!,UIImage(named:"Alchohol")!]
    
    var listOfSectionsCopiedArray :[String]=[]
    var listOfProducts = ListOfProducts()
    
    override func viewDidLoad() {
        CollectionView.backgroundColor = UIColor.clearColor()
        listOfSectionsCopiedArray = ["Vegetables","Fruits","Dairy","Candy","Meat","Cleaning","Drinks","Alchohol"]
    }
    
    override func viewWillAppear(animated: Bool) {
        print("aaa")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! Buying_online_cell
        
        cell.ImageViewCell.image = imagesArray[indexPath.row]
        cell.LabelCell.text = listOfSectionsCopiedArray[indexPath.row]
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProductList") as! Products_List
        vc.section=listOfSectionsCopiedArray[indexPath.row]
        vc.listOfProducts = self.listOfProducts
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segShoppingList"{
            let vc = segue.destinationViewController as! Shopping_List_Before_Payment
            vc.listOfProducts = self.listOfProducts
    }
    }
    
    
    
    
    
    
    

}
