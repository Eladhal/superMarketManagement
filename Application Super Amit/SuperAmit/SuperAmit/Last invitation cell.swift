//
//  Last invitation cell.swift
//  SuperAmit
//
//  Created by elad halperin on 8/1/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

protocol Last_invitation_protocol{
    func btnRemoveProductTapped(sender:Last_invitation_cell)
}


class Last_invitation_cell: UITableViewCell {
    var delegate:Last_invitation_protocol?
    
    @IBOutlet weak var imageShopListCell: UIImageView!
    
    @IBOutlet weak var tilteShopListCell: UILabel!
    
    @IBOutlet weak var priceShopListCell: UILabel!
    
    @IBAction func btnRemoveProduct(sender: AnyObject) {
        
        if delegate != nil{
            delegate?.btnRemoveProductTapped(self)
        }
    }
}
