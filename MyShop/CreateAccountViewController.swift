//
//  CreateAccountViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 11/8/2023.
//

import UIKit
import Firebase
import FirebaseFirestore



class CreateAccountViewController: UIViewController {
    
    var database = Firestore.firestore()
    
    @IBOutlet weak var nametxt: UITextField!
    
    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var passwordtxt: UITextField!
    
    @IBOutlet weak var confirmpasstxt: UITextField!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

       
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
                
        guard let email = emailtxt.text, !email.isEmpty else {
            callAlert(title: "Account Creation Unsuccessful", message: "Email is left blank")
            return
        }
        guard let name = nametxt.text, !name.isEmpty else {
            callAlert(title: "Account Creation Unsuccessful", message: "Name is left blank")
            return
        }
        guard let password = passwordtxt.text, !password.isEmpty else {
            callAlert(title: "Account Creation Unsuccessful", message: "Password is left blank")
            return
        }
        guard let confirmPass = confirmpasstxt.text, confirmPass == password else {
            callAlert(title: "Account Creation Unsuccessful", message: "Ensure passwords match and no fields are blank")
            return
        }
            
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                debugPrint(error)
                self.callAlert(title: "Account Creation Unsuccessful", message: "Re-examine data entered including email format")
                return
            }
            print("Successfully registered new user")
            self.saveUser(username: email, name: name)
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
        
        func callAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    func saveUser(username: String, name: String){
        
        let docRef = database.document("users/\(username)")
        docRef.setData(["name": name , "username": username, "cart": []])
            
        }
    }
