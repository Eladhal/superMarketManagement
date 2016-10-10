//
//  ListOfProducts.swift
//  SuperAmit
//
//  Created by elad halperin on 7/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import Foundation

class ListOfProducts{
    
    var totalList:[String:[Product]]=[:]
    var discount:[String]
    
    init()
    {
            
        totalList = ["Vegetables":[Product(name: "Tomato",cost: 0.1,imageName:"Tomato" ),Product(name: "Cucumber",cost: 0.2,imageName:"Cucumber" ),Product(name: "Carrot",cost: 0.1,imageName: "Carrot"),Product(name: "Broccoli",cost: 0.3,imageName: "Broccoli"),Product(name: "Onion",cost: 0.2,imageName: "Onion"),Product(name: "Pepper",cost: 0.2,imageName: "Pepper"),Product(name: "Eggplant",cost: 0.3,imageName: "Eggplant"),Product(name: "Garlic",cost: 0.1,imageName: "Garlic")],"Fruits":[Product(name:"Apple",cost:0.1,imageName: "Apple"),Product(name:"Pear",cost:0.1,imageName: "Pear"),Product(name:"Banana",cost:0.2,imageName: "Banana"),Product(name:"Grapes",cost:0.3,imageName: "Grapes"),Product(name:"Melon",cost:0.4,imageName: "Melon"),Product(name:"Watermelon",cost:0.5,imageName: "Watermelon")],"Dairy":[Product(name:"Cow milk",cost:2,imageName:"Cow milk"),Product(name:"Cream cheese",cost:5,imageName:"Cream cheese"),Product(name:"Goat milk",cost:4.5,imageName:"Goat milk"),Product(name: "Ricotta cheese",cost: 5.5,imageName: "Ricotta cheese"),Product(name:"Yellow cheese",cost:3.2,imageName: "Yellow cheese"),Product(name: "Yogurt",cost: 2.2,imageName: "Yogurt")],"Candy":[Product(name: "Biscuit",cost: 1,imageName: "Biscuit"),Product(name: "Candies",cost: 1.2,imageName: "Candies"),Product(name: "Chocolate",cost: 2,imageName: "Chocolate"),Product(name: "Cookies ",cost: 3,imageName: "Cookies"),Product(name: "Wafer",cost: 1.5,imageName: "Wafer"),Product(name: "White chocolate",cost: 2.3,imageName: "White chocolate")],"Meat":[Product(name: "Antricot",cost: 30,imageName: "Antricot"),Product(name: "Beef fillet",cost: 35,imageName: "Beef fillet"),Product(name: "Sinta",cost: 32,imageName: "Sinta"),Product(name: "Chicken breast",cost: 15,imageName: "Chicken breast"),Product(name: "Chicken",cost: 10,imageName: "Chicken"),Product(name: "Hotdog",cost: 8,imageName: "Hotdog")],"Cleaning":[Product(name: "Bleach",cost: 5,imageName: "Bleach"),Product(name: "Broom",cost: 3,imageName: "Broom"),Product(name: "Detergent",cost: 6,imageName: "Detergent"),Product(name: "Dustpan",cost: 1.5,imageName: "Dustpan"),Product(name: "Mop",cost: 2,imageName: "Mop"),Product(name: "Rag",cost: 1,imageName: "Rag")],"Drinks":[Product(name: "Coca cola",cost: 1.8,imageName: "Coca cola"),Product(name: "Fanta",cost: 1.5,imageName: "Fanta"),Product(name: "Grapes",cost: 1.6,imageName: "Grapes"),Product(name: "Soda",cost: 1.5,imageName: "Soda"),Product(name: "Sprite",cost: 1.6,imageName: "Sprite"),Product(name: "Water",cost: 0.8,imageName: "Water")],"Alchohol":[Product(name: "Arack",cost: 8,imageName: "Arack"),Product(name: "Beer",cost: 6,imageName: "Beer"),Product(name: "Koniak",cost: 50,imageName: "Koniak"),Product(name: "Vodka",cost: 25,imageName: "Vodka"),Product(name: "Whiskey",cost: 45,imageName: "Whiskey"),Product(name: "Wine",cost: 15,imageName: "Wine")]]
        
        discount = ["Tomato","Carrot","Eggplant","Pepper"]
    }
    
    
    

}
