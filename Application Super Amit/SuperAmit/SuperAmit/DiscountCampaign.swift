//
//  DiscountCampaign.swift
//  SuperAmit
//
//  Created by elad halperin on 8/8/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class DiscountCampaign: UICollectionViewController {
    
    var listOfProducts = ListOfProducts()
    var discountProducts:[String:Double]=[:]
    override func viewDidLoad() {
        
        for (section,products) in listOfProducts.totalList{
            for product in products{
                for productName in listOfProducts.discount{
                    if productName == product.name{
                        discountProducts[productName]=product.cost
                    }
                }
            }
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfProducts.discount.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let productName = listOfProducts.discount[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("discountCell", forIndexPath: indexPath) as! Discount_campaign_cell
        cell.discountImageCell.image = UIImage(named: productName)
        cell.discountProductLabel.text = productName+" in sale!"
        cell.discountPriceLabel.text = "For "+"\(discountProducts[productName]!)"+"$"
        return cell
    }
    

}
