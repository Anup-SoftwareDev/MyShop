//
//  ProductDetailViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 7/8/2023.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var productDescription: UITextView!
    
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var addCartBtn: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // Add a target to the addCartBtn to call the addItemToCart method when clicked
            addCartBtn.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
        }

        @objc func addItemToCart() {
            // Create an alert
            let alert = UIAlertController(title: "Item Added to Cart:", message: "iPhone Pro Max", preferredStyle: .alert)
            
            // Add an "OK" button to the alert
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Present the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }


