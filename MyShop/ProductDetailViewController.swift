//
//  ProductDetailViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 7/8/2023.
//

import UIKit
import Firebase

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var productDescription: UITextView!
    
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var addCartBtn: UIButton!
    
    @IBOutlet weak var cartBtn: UIBarButtonItem!
    
    @IBOutlet weak var greetingLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let greetingManager = GreetingLabelManager()
        greetingLbl.text = greetingManager.getGreeting()
        
        addCartBtn.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
        
        
        }
    
    @IBAction func buyBtnClicked(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
                performSegue(withIdentifier: "toBuy", sender: self)
            } else {
                let alert = UIAlertController(title: "Log in Required", message: "Need to Log in to Buy", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                    self?.performSegue(withIdentifier: "toLogin", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        
    }
    
    
    @IBAction func cartBtnClicked(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
                performSegue(withIdentifier: "toCart", sender: self)
            } else {
                let alert = UIAlertController(title: "Log in Required", message: "Need to Log in to view Cart Items", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                    self?.performSegue(withIdentifier: "toLogin", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        
        
        
    }

    

        @objc func addItemToCart() {
            
            if let user = Auth.auth().currentUser {
                    
            // Create an alert
            let alert = UIAlertController(title: "Item Added to Cart:", message: "iPhone Pro Max", preferredStyle: .alert)
            
            // Add an "OK" button to the alert
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Present the alert
            self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Log in Required", message: "Need to Log in to add items to Cart", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                    self?.performSegue(withIdentifier: "toLogin", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let user = Auth.auth().currentUser {
           
            if let email = user.email {
                //greetingLbl.text = ("Hi \(email)")
                if let email = user.email {
                    if let range = email.range(of: "@") {
                        var name = String(email[..<range.lowerBound])
                        name = name.prefix(1).capitalized + name.dropFirst()
                        greetingLbl.text = ("Hi \(name)")
                    }
                    
                }
                
            }
        } else {
            
            greetingLbl.text = "Hi Guest"
        }
        
    }
        
    }


