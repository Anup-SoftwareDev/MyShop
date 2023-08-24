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
    var product = ProductCellCVCell()
       
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
        setUpCartBadge()
        setUpGreetingLbl()
        setUpProductDetails()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let cartItemIndexes = DataHolder.shared.cartIndexNumbers
        setUpCartBadge()
        setUpGreetingLbl()
        if cartItemIndexes.count > 0{
            print(cartItemIndexes.count)
            cartBtn.setBadge(with: cartItemIndexes.count)
        }else{
            cartBtn.removeBadge()
        }
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
        
        handleActionIfAuthenticated(segueIfAuthenticated: "toBuy", alertMessage: "Need to Log in to Buy")

    }
    
    
    @IBAction func cartBtnClicked(_ sender: Any) {
        
        handleActionIfAuthenticated(segueIfAuthenticated: "toCart", alertMessage: "Need to Log in to view Cart Items")

    }

    

    @objc func addItemToCart() {
        
        DataHolder.shared.cartIndexNumbers.append(productIndex!)
        
        if Auth.auth().currentUser != nil {
            cartBtn.setBadge(with: DataHolder.shared.cartIndexNumbers.count)
            presentAlert(title: "Item Added to Cart:", message: "\(product.productNames[productIndex!]) - \(String(format: "A$ %.2f", product.productPrices[productIndex!]))")
        } else {
            presentAlert(title: "Log in Required", message: "Need to Log in to add items to Cart", completion: { [weak self] _ in
                self?.performSegue(withIdentifier: "toLogin", sender: self)
            })
        }
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////
    // Call Functions to simplify code above//////
    ///////////////////////////////////////////////////////////////////////////////////
    
    private func setUpCartBadge(){
        let cartItemIndexes = DataHolder.shared.cartIndexNumbers
        print(cartItemIndexes)
        if cartItemIndexes.count > 0{
            cartBtn.setBadge(with: cartItemIndexes.count)
        }
        
    }
    
    private func setUpGreetingLbl() {
        let greetingManager = GreetingLabelManager()
        greetingLbl.text = greetingManager.getGreeting()
        
    }
    
    private func setUpProductDetails(){
        imageView.image = UIImage(named: product.imageNames[productIndex!])
        productLbl.text = product.productNames[productIndex!]
        priceLbl.text = "\(String(format: "A$ %.2f", product.productPrices[productIndex!]))"
        addCartBtn.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
    }
    
    // Helper function to present alerts
    func presentAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleActionIfAuthenticated(segueIfAuthenticated: String, alertMessage: String) {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: segueIfAuthenticated, sender: self)
        } else {
            presentAlert(title: "Log in Required", message: alertMessage, completion: { [weak self] _ in
                self?.performSegue(withIdentifier: "toLogin", sender: self)
            })
        }
    }
    }
