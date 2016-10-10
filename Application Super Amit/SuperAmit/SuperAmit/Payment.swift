//
//  Payment.swift
//  SuperAmit
//
//  Created by elad halperin on 7/25/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class Payment:UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var FirstNameText: UITextField!
    
    @IBOutlet weak var LastNameText: UITextField!
    
    @IBOutlet weak var CreditCardText: UITextField!
    
    @IBOutlet weak var PaymentTypeText: UITextField!
    
    @IBOutlet weak var DayText: UITextField!
    
    @IBOutlet weak var MonthText: UITextField!
    
    @IBOutlet weak var YearText: UITextField!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    var listOfShopping : [String:[Product]]?
    
    var ref:FIRDatabaseReference!
    
    var alert:UIAlertView?
    
    let paymentList = ["VISA","ISRACARD","AMERICAN EXPRESS"]
    
    override func viewDidLoad() {
        let userID : String = (FIRAuth.auth()?.currentUser?.uid)!
        ref = FIRDatabase.database().reference().child(userID)
        ref.observeEventType(FIRDataEventType.Value,withBlock: { (snapshot) in
            let DBDict = snapshot.value as! [String:AnyObject]
            self.FirstNameText.text = DBDict["First name"] as! String
            self.LastNameText.text = DBDict["Last name"] as! String
        })
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) { // Force keyboard disapper after touching outsude the UITextfield
        self.view.endEditing(true)
    }
    
    /// PICKER VIEW
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentList.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return paymentList[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.PaymentTypeText.text=paymentList[row]
        self.dropDown.hidden = true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.endEditing(false)
        if textField == PaymentTypeText{
            self.dropDown.hidden = false
        }
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        var data = paymentList[row]
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0, weight: UIFontWeightRegular)])
        label.attributedText = title
        label.textAlignment = .Center
        return label
    }
    
    ///


    
    @IBAction func PaymentBtn(sender: UIButton) {
        
        if (CreditCardText.text != "" && PaymentTypeText.text != "" && DayText.text != "" && MonthText.text != "" && YearText.text != "" ){
            
            let userid:String = (FIRAuth.auth()?.currentUser?.uid)!
            ref = FIRDatabase.database().reference().child(userid)
            ref.child("Shopping cart").removeValue() // clear the older shopping cart
            
            for (section,products) in self.listOfShopping!
            {
                for product in products
                {
                    self.ref.child("Shopping cart").child(section).child(product.name).setValue(["name":product.name,"cost":product.cost,"image":product.imageName,"quantity":product.quantity])
                }
            }
            
            let message = UIAlertController(title: "", message: "Thanks for buying at SUPERAMIT!", preferredStyle:UIAlertControllerStyle.Alert)
            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) in
                let vc:UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("Main Page"))!
                self.presentViewController(vc, animated: true, completion: nil)
            })
            
            message.addAction(actionOK)
            
            self.presentViewController(message, animated: true, completion: nil)

        }
        else {
            self.alert = UIAlertView(title: "Notice", message: "Fill all the fields!", delegate: self, cancelButtonTitle: "OK")
            self.alert?.show()
        }
        
        
    }
}

    
    

