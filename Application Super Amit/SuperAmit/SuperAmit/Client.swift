//
//  Client.swift
//  SuperAmit
//
//  Created by elad halperin on 7/12/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Person
{
    var name:String
    var email:String
    var shopList=[String:[String:Int]]() // [FoodType:[Product:Quantity]]
    
    init(name:String,email:String)
    {
        self.name = name
        self.email = email
    }
    init()
    {
        name=""
        email=""
    }
 
    
}
