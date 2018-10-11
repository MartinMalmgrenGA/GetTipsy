//
//  ViewController.swift
//  GetTipsy
//
//  Created by Martin Malmgren on 2018-10-10.
//  Copyright © 2018 Martin Malmgren. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var CreateAccountButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var WrongLabel: UILabel!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var ImageLogoWith: NSLayoutConstraint!
    @IBOutlet weak var ImageLogo: UIImageView!
    @IBOutlet weak var Loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageLogoWith.constant = ImageLogo.frame.height
        
        EmailTextfield.delegate = self
        PasswordTextfield.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func setAllEnable(bool : Bool){
        CreateAccountButton.isEnabled = bool
        LoginButton.isEnabled = bool
        EmailTextfield.isEnabled = bool
        PasswordTextfield.isEnabled = bool
        
        if(bool == false){
            CreateAccountButton.alpha = 0.5
            LoginButton.alpha = 0.5
            EmailTextfield.alpha = 0.5
            PasswordTextfield.alpha = 0.5
        }
        else {
            CreateAccountButton.alpha = 1
            LoginButton.alpha = 1
            EmailTextfield.alpha = 1
            PasswordTextfield.alpha = 1
        }
    }
    func login(email : String, password : String){
        setAllEnable(bool: false)
        Loader.startAnimating()
        WrongLabel.text = ""
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if(error == nil){
                self.Loader.stopAnimating()
                self.performSegue(withIdentifier: "LoginToList", sender: self)
                self.setAllEnable(bool: true)
            }
            else{
                self.Loader.stopAnimating()
                self.WrongLabel.text = "Fel lösenord eller användarnamn."
                self.setAllEnable(bool: true)
            }
        }
    }
    @IBAction func LoginClick(_ sender: Any) {
        login(email: EmailTextfield.text!, password: PasswordTextfield.text!)
    }
}

