//
//  Shopping List cell.swift
//  SuperAmit
//
//  Created by elad halperin on 7/19/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

protocol Shoping_List_Protocol{
    func btnRemoveProductTapped(sender:Shopping_List_cell)
}

class Shopping_List_cell: UITableViewCell {
    
    var delegate:Shoping_List_Protocol?

    @IBOutlet weak var imageShopListCell: UIImageView!
    
    @IBOutlet weak var tilteShopListCell: UILabel!
    
    @IBOutlet weak var priceShopListCell: UILabel!
    
    @IBAction func btnRemoveProduct(sender: AnyObject) {
        
        if delegate != nil{
            delegate?.btnRemoveProductTapped(self)
        }
    }
    
    
}
