//
//  ProductDetailViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 7/8/2023.
//

import UIKit
import Firebase

class ProductDetailViewController: UIViewController {
    
    var productIndex: Int?
   
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
        let product = ProductCellCVCell()
        imageView.image = UIImage(named: product.imageNames[productIndex!])
        productLbl.text = product.productNames[productIndex!]
        priceLbl.text = "A$ \(String(product.productPrices[productIndex!]))"
        
        addCartBtn.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
        
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBuy",
           let destinationVC = segue.destination as? BuyNowViewController {
            if let index = productIndex {
                destinationVC.index = index
            }
        }
    }
    @IBAction func buyBtnClicked(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
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
        
        if Auth.auth().currentUser != nil {
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
            
            if Auth.auth().currentUser != nil {
                    
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
        
        let greetingManager = GreetingLabelManager()
        greetingLbl.text = greetingManager.getGreeting()
        
    }
        
    }


