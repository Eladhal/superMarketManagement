//
//  ForgotPassword.swift
//  SuperAmit
//
//  Created by elad halperin on 7/6/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPassword: UIViewController {
    
    @IBOutlet weak var userEmailText: UITextField!
    var alert:UIAlertView?
    
    @IBAction func BtnResetPassword(sender: UIButton) {
        
        if userEmailText.text != ""
        {
            FIRAuth.auth()?.sendPasswordResetWithEmail(userEmailText.text!, completion: { (error) in
                if error == nil
                {
                    self.alert = UIAlertView(title: "Notice", message: "An email with reset password send to you", delegate: self, cancelButtonTitle:"OK")
                    self.alert?.show()
                    let vc:UIViewController=(self.storyboard?.instantiateViewControllerWithIdentifier("LOGIN"))!
                    self.presentViewController(vc, animated: true, completion:nil)
                }
                else{
                    self.alert = UIAlertView(title: "Notice", message: error?.localizedDescription, delegate: self, cancelButtonTitle:"OK")
                    self.alert?.show()
                }
            })
        }
        else
        {
            
        
        }
        

    }

}
