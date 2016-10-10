//
//  MainPage.swift
//  SuperAmit
//
//  Created by elad halperin on 7/7/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class MainPage: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let arrayOfTitles:[String]=["Buying online","Last invitation","Update personal info","Locate in map","Special prices","Client service"]
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfTitles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MainPageCell
        
        cell.MainPageCellLabel.text=arrayOfTitles[indexPath.row]
        
        return cell
        
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch arrayOfTitles[indexPath.row]
        {
            case "Buying online":
            self.performSegueWithIdentifier("SegBuyingOnLine", sender: self)

            case "Last invitation":
                self.performSegueWithIdentifier("SegLastInvitation", sender: self)
            
            case "Update personal info":
                self.performSegueWithIdentifier("SegUpdatePersonalInfo", sender: self)
            
            case "Locate in map":
                self.performSegueWithIdentifier("SegLocateInMap", sender: self)
                
            case "Special prices":
                self.performSegueWithIdentifier("SegSpecialPrices", sender: self)
                
            case "Client service":
                self.performSegueWithIdentifier("SegClientService", sender: self)
            
            default:
                print("")
  
        }
    }
    
    
        
        
    }
    


