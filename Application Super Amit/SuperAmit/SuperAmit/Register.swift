//
//  Register.swift
//  SuperAmit
//
//  Created by elad halperin on 7/4/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Register: UIViewController {
    
    @IBOutlet weak var UserNameText: UITextField!
    
    @IBOutlet weak var UserEmailText: UITextField!

    @IBOutlet weak var UserPasswordText: UITextField!
    
    @IBOutlet weak var RepeatPasswordText: UITextField!
    
    @IBOutlet weak var LastNameText: UITextField!
    
    var alert:UIAlertView?
    
    var ref:FIRDatabaseReference!
    
    override func viewDidLoad() {
        
        ref=FIRDatabase.database().reference()
    }
    
    @IBAction func Register(sender: UIButton) {
        
        if (UserNameText.text != "" && UserEmailText.text != "" && UserPasswordText.text != "" && RepeatPasswordText.text != "" && LastNameText.text != "")
        {
            if (UserPasswordText.text == RepeatPasswordText.text)
            {
                if (UserPasswordText.text?.characters.count)>=6
                {
                FIRAuth.auth()?.createUserWithEmail(UserEmailText.text!, password: UserPasswordText.text!, completion:{(user,error)in
                    if error == nil {
                        self.ref.child(user!.uid).setValue(["First name":self.UserNameText.text!,"Last name":self.LastNameText.text!,"Shopping cart":"Shopping cart"])
                        let vc:UIViewController=(self.storyboard?.instantiateViewControllerWithIdentifier("Main Page"))!
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else {
                        self.alert = UIAlertView(title: "Notice", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "Ok")
                        self.alert!.show()
                    }
                    
                })
                    }
                else{
                    alert = UIAlertView(title: "Notice", message: "The password must contain at least 6 characters", delegate: self, cancelButtonTitle: "Ok")
                    alert!.show()
                }
                
            }
            else
            {
               alert = UIAlertView(title: "Notice", message: "Password don't match", delegate: self, cancelButtonTitle: "OK")
                alert!.show()
            }
        }
        else {
            alert = UIAlertView(title: "Notice", message: "Missing data", delegate: self, cancelButtonTitle: "OK")
            alert!.show()
        }
    }
    
    
    
}
