//
//  Product List Cell.swift
//  SuperAmit
//
//  Created by elad halperin on 7/12/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

protocol ProductListProtocol {
    
    func btnPlusTapped(sender:Product_List_Cell)
    func btnMinusTapped(sender:Product_List_Cell)
}



class Product_List_Cell: UITableViewCell {

    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var TopicLabel: UILabel!
    @IBOutlet weak var quantityText: UITextField!

    @IBOutlet weak var PriceLabel: UILabel!
    var delegate : ProductListProtocol?
    
    @IBAction func btnMinus(sender: UIButton) {
        
        if delegate != nil{
            delegate?.btnMinusTapped(self)
        }
        
    }
    @IBAction func btnPlus(sender: UIButton) {
        if delegate != nil{
            delegate?.btnPlusTapped(self)
        }
    }

    
}
