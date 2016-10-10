//
//  ViewController.swift
//  SuperAmit
//
//  Created by elad halperin on 6/29/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Login: UIViewController {

    @IBOutlet weak var UserEmailText: UITextField!
    @IBOutlet weak var UserPasswordText: UITextField!
    var alert:UIAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
       // super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func BtnLogin(sender: UIButton) {
        
        if UserEmailText.text != "" && UserPasswordText.text != ""
        {
            FIRAuth.auth()?.signInWithEmail(UserEmailText.text!, password: UserPasswordText.text!, completion: { user, error in
                if error == nil {
                  let vc:UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("Main Page"))!
                  self.presentViewController(vc, animated: true, completion: nil)
                }
                else{
                    self.alert = UIAlertView(title: "Notice", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                    self.alert?.show()
                }
            })

        }
        else {
            alert = UIAlertView(title: "Notice", message: "Missing data", delegate: self, cancelButtonTitle: "OK")
            alert?.show()
        }
        
    }


}

