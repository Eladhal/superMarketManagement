//
//  UpdateInfo.swift
//  SuperAmit
//
//  Created by elad halperin on 8/6/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UpdateInfo: UIViewController {
    
    var ref:FIRDatabaseReference!
    
    var alert:UIAlertView?
    
    @IBOutlet weak var firstNameText: UITextField!
    
    @IBOutlet weak var lastNameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    override func viewDidLoad() {
        let userID : String = (FIRAuth.auth()?.currentUser?.uid)!
        ref = FIRDatabase.database().reference().child(userID)
        ref.observeEventType(FIRDataEventType.Value,withBlock: { (snapshot) in
            if let DBDict = snapshot.value as? [String:AnyObject]{
            self.firstNameText.text = DBDict["First name"] as! String
            self.lastNameText.text = DBDict["Last name"] as! String
            }
        })
        emailText.text = FIRAuth.auth()?.currentUser?.email
    }
    
    
    @IBAction func btnUpdate(sender: AnyObject) {
        
        if (firstNameText.text != "" && lastNameText.text != "" && emailText.text != "" && passwordText.text == confirmPasswordText.text){
            if (passwordText.text?.characters.count==0 || passwordText.text?.characters.count>5){
            ref.updateChildValues(["First name":firstNameText.text!,"Last name":lastNameText.text!])
                if let user = FIRAuth.auth()?.currentUser{
                    user.updateEmail(emailText.text!, completion: { (error) in
                        if error != nil{
                            self.alert = UIAlertView(title: "Notice", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                            self.alert?.show()
                        }
                    })
                    user.updatePassword(passwordText.text!, completion: { (error) in
                        if error != nil{
                            self.alert = UIAlertView(title: "Notice", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                           self.alert?.show()
                        }
                    })
                }
                self.navigationController?.popViewControllerAnimated(true)
            }
            else{ // Password is not valid
                self.alert = UIAlertView(title: "Notice", message: "Passord is not valid", delegate: self, cancelButtonTitle: "OK")
                self.alert?.show()
           }
        }
        else{
            self.alert = UIAlertView(title: "Notice", message: "Missing data", delegate: self, cancelButtonTitle: "OK")
            self.alert?.show()
        }
        
        
    }
    

}
