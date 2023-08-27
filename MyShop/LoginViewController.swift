//
//  LoginViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 11/8/2023.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController:
UIViewController {

    
    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var passwordtxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    
    @IBAction func forgotPassClicked(_ sender: Any) {
        
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        
        guard let email = emailtxt.text, !email.isEmpty else {
            callAlert(title: "Log in Unsuccessful", message: "Email is left blank")
            return
        }
       
        guard let password = passwordtxt.text, !password.isEmpty else {
            callAlert(title: "Login Unsuccessful", message: "Password is left blank")
            return
        }
    
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error{
                debugPrint(error)
                self.callAlert(title: "Log in Unsuccessful", message: "Re-examine data entered including email format")
                return
            }
            print("succesfully logged in new user")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
}
