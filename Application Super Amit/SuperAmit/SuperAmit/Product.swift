//
//  Product.swift
//  SuperAmit
//
//  Created by elad halperin on 7/12/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Product : NSObject {
    
    var name:String
    var cost:Double
    var imageName:String
    var quantity:Int
    
    init(name:String,cost:Double,imageName:String)
    {
        self.name=name
        self.cost=cost
        self.imageName = imageName //UIImage(named: imageName)!
        self.quantity = 0
    }
    override init()
    {
        self.name=""
        self.cost=0
        self.imageName = ""
        self.quantity=0
    }
  
}
