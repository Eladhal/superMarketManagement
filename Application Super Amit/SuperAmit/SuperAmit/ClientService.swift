//
//  ClientService.swift
//  SuperAmit
//
//  Created by elad halperin on 8/8/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ClientService: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let subjects:[String] = ["PAYMENT","PRODUCTS","SERVICE","GENERAL"]
    
    var ref:FIRDatabaseReference!
    
    @IBOutlet weak var firstNameText: UITextField!
    
    @IBOutlet weak var lastNameText: UITextField!

    @IBOutlet weak var subjectText: UITextField!
    
    @IBOutlet weak var subjectPickerView: UIPickerView!
    
    var alert:UIAlertView?
    
    let userID : String = ""
    
    var clientServiceArray:[String]=[]
    
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        firstNameText.layer.borderWidth=1.0
        lastNameText.layer.borderWidth=1.0
        subjectText.layer.borderWidth=1.0
        messageTextView.layer.borderWidth=1.0
        
        let userID : String = (FIRAuth.auth()?.currentUser?.uid)!
        ref = FIRDatabase.database().reference().child(userID)
        ref.observeEventType(FIRDataEventType.Value,withBlock: { (snapshot) in
            let DBDict = snapshot.value as! [String:AnyObject]
            self.firstNameText.text = DBDict["First name"] as! String
            self.lastNameText.text = DBDict["Last name"] as! String
    })
    }
    /// PICKER VIEW
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return subjects[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subjectText.text = subjects[row]
        self.subjectPickerView.hidden = true
        
    }
    ///
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.endEditing(false)
        if textField == subjectText{
            self.subjectPickerView.hidden = false
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        let data = subjects[row]
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0, weight: UIFontWeightRegular)])
        label.attributedText = title
        label.textAlignment = .Center
        return label
    }
    
    @IBAction func btnSend(sender: AnyObject) {
        if (subjectText.text != "") && (messageTextView.text != "") {
            self.ref.child("ClientService").childByAutoId().setValue(self.messageTextView.text)
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            alert = UIAlertView(title: "Notice", message: "Missing Data", delegate: self, cancelButtonTitle: "Ok")
            alert?.show()
        }
    }
    
    
    @IBAction func btnCancel(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    
    
}
