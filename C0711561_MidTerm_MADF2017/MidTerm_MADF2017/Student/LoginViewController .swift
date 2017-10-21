//
//  ViewController.swift
//  MidTerm_MADF2017
//
//  Created by moxDroid on 2017-10-20.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Student ID : 
//  Student Name :

import UIKit

class LoginViewController : UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
        
        // REMOVER
        textFieldEmail.text = "c0711561@mylambton.ca"
        textFieldPassword.text = "c0711561"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func loginButtonTap(_ sender: Any) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            if isValidUserEntries(email, password) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                showInvalidLoginAlert()
            }
        }
    }
    
    // MARK: Private Actions - auxiliares methods
    
    fileprivate func isValidUserEntries(_ email: String, _ password: String) -> Bool {
        return email == "c0711561@mylambton.ca" && password == "c0711561"
    }
    
    fileprivate func showInvalidLoginAlert() {
        let invalidLoginMessage = UIAlertController(title: "Invalid Login", message: "Invalid user email or password", preferredStyle: .alert)
        invalidLoginMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(invalidLoginMessage, animated: true, completion: nil)
    }
    
}

