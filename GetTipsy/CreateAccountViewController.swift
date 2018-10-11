//
//  CreateAccountViewController.swift
//  GetTipsy
//
//  Created by Martin Malmgren on 2018-10-10.
//  Copyright © 2018 Martin Malmgren. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var termsSwitch: UISwitch!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var MakeAccountLabel: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var CreateAccountButton: UIButton!
    @IBOutlet weak var Loader: UIActivityIndicatorView!
    @IBOutlet weak var CompanyTextfield: UITextField!
    @IBOutlet weak var RepeatPasswordTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var NameTextfield: UITextField!
    @IBOutlet weak var EmailTextfield: UITextField!
    
    override func viewDidLoad() {
        EmailTextfield.delegate = self
        NameTextfield.delegate = self
        PasswordTextfield.delegate = self
        RepeatPasswordTextfield.delegate = self
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func BackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func setEnable(bool : Bool){
        BackButton.isEnabled = bool
        CreateAccountButton.isEnabled = bool
        CompanyTextfield.isEnabled = bool
        RepeatPasswordTextfield.isEnabled = bool
        PasswordTextfield.isEnabled = bool
        NameTextfield.isEnabled = bool
        EmailTextfield.isEnabled = bool
        termsButton.isEnabled = bool
        
        if(bool == true){
           Loader.stopAnimating()
            MakeAccountLabel.alpha = 1
            BackButton.alpha = 1
            CreateAccountButton.alpha = 1
            CompanyTextfield.alpha = 1
            RepeatPasswordTextfield.alpha = 1
            PasswordTextfield.alpha = 1
            NameTextfield.alpha = 1
            EmailTextfield.alpha = 1
            termsButton.alpha = 1
            termsSwitch.alpha = 1
        }
        else {
            Loader.startAnimating()
            MakeAccountLabel.alpha = 0.5
            BackButton.alpha = 0.5
            CreateAccountButton.alpha = 0.5
            CompanyTextfield.alpha = 0.5
            RepeatPasswordTextfield.alpha = 0.5
            PasswordTextfield.alpha = 0.5
            NameTextfield.alpha = 0.5
            EmailTextfield.alpha = 0.5
            termsButton.alpha = 0.5
            termsLabel.alpha = 0.5
            termsSwitch.alpha = 0.5
            
            
        }
    }
    func postToDBLeads(email : String, name : String, company : String) {
        
        let date = Date()
        let dateString = String(describing: date)
        
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "Namn": name,
            "Email": email,
            "Company": company,
            "Date": dateString
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func login(email : String, password : String) {
        var bool = Bool()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if(error == nil){
                self.postToDBLeads(email: self.EmailTextfield.text!, name: self.NameTextfield.text!, company: self.CompanyTextfield.text!)
                self.performSegue(withIdentifier: "CreateToLogin", sender: self)
                
            }
            else {
                self.navigationController?.popViewController(animated: true)
            }
            self.setEnable(bool: true)
        }
        
        
    }
    func createUser(email : String, password : String){
        setEnable(bool: false)
        let AH = AlertHandler()
        if(NameTextfield.text != "" && EmailTextfield.text != "" && PasswordTextfield.text != "" && RepeatPasswordTextfield.text != ""){
            if(termsSwitch.isOn == true){
            if(PasswordTextfield.text == RepeatPasswordTextfield.text){
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if(error == nil){
               self.login(email: email, password: password)
            }
            else {
                 AH.Alert(title: "Fel", Message: "Något gick fel. Försök igen.", ButtonTitle: "OK", sender: self)
                self.setEnable(bool: true)
            }
        }
    }
            else {
                AH.Alert(title: "Fel", Message: "Lösenorden matchar inte.", ButtonTitle: "OK", sender: self)
                self.setEnable(bool: true)
            }
            }
            else {
                AH.Alert(title: "Fel", Message: "Du måste godkänna de allmänna villkoren.", ButtonTitle: "OK", sender: self)
                self.setEnable(bool: true)
            }
}
        else {
            AH.Alert(title: "Fel", Message: "Du har inte fyllt i alla fällt.", ButtonTitle: "OK", sender: self)
            self.setEnable(bool: true)
        }
    }
    @IBAction func CreateUser(_ sender: Any) {
        
            createUser(email: EmailTextfield.text!, password: PasswordTextfield.text!)
           
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
