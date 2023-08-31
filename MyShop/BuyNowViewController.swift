//
//  BuyNowViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 9/8/2023.
//

import UIKit
import Firebase
import StripePaymentSheet


class BuyNowViewController: UIViewController {

    //@IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var greetingLbl: UILabel!
    
    @IBOutlet weak var payBtn: UIButton!
    
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    
    @IBOutlet weak var processingFeeLbl: UILabel!
    
    @IBOutlet weak var totalFeeLbl: UILabel!
    
    var totalPrice: Double = 0.0 // Add this line
    var paymentSheet: PaymentSheet?
    let backendCheckoutUrl = URL(string: "https://myshopbackend.onrender.com/payment-sheet")! // Your backend endpoint
    //let backendCheckoutUrl = URL(string: "http://localhost:3002/payment-sheet")! // Your backend endpoint
    let product = ProductCellCVCell()
    
    var index = 1
//    var productImage = "watch"
//    var productLbl = "Watch"
//    var productPrice = 42000.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let productImage = self.product.imageNames[self.index]
        let productName = self.product.productNames[self.index]
        let productPrice = self.product.productPrices[self.index]
        let shippingPrice = 50.00
        let processingFee = 25.00
        totalPrice = productPrice + shippingPrice + processingFee
//        self.productImage = productImage
//        self.productLbl = productName
//        self.productPrice = productPrice
        
        self.productImage.image = UIImage(named: productImage)
        self.productName.text = productName
        self.productPrice.text = String(format: "A$ %.2f", productPrice)
        
        // Setup Lables
        
        priceLbl.text = String(format: "A$ %.2f", productPrice)
        shippingLbl.text = String(format: "A$ %.2f", shippingPrice)
        processingFeeLbl.text = String(format: "A$ %.2f", processingFee)
        totalFeeLbl.text = String(format: "A$ %.2f", totalPrice)
    
        
        setupGreetingLbl()
        payBtn.titleLabel?.font = UIFont.init(name: "GillSans-Italic", size: 30)
        payBtn.setTitle("Please Wait. Loading Payment System ...", for: .normal)
        payBtn.tintColor = UIColor.darkGray
        //payBtn.setTitle(String(format: "Confirm and Pay - A$ %.2f", totalPrice), for: .normal)
        //payBtn.titleLabel?.font = UIFont.init(name: "GillSans-Italic", size: 30)
        //payBtn.isEnabled = false
        configurePaymentSheet()
        
    }
    
    
    @IBAction func payBtnClicked(_ sender: Any) {
        
        configurePaymentSheet()
      // MARK: Start the checkout process
        paymentSheet?.present(from: self) { [unowned self] paymentResult in
        // MARK: Handle the payment result
          print("Payment Result: \(paymentResult)")
        switch paymentResult {
        case .completed:
          print("Your order is confirmed")
            self.performSegue(withIdentifier: "toPaymentConfirmation", sender: self)
        case .canceled:
          print("Canceled!")
        case .failed(let error):
          print("Payment failed: \(error)")
        }
          

      }
        
    }
    
    private func setupGreetingLbl(){
        let greetingManager = GreetingLabelManager()
        DispatchQueue.main.async {
            greetingManager.getGreeting{[self]greeting in
                self.greetingLbl.text = greeting
            }
        }
    }


    
    private func configurePaymentSheet() {
           let paymentSheetConfigurator = PaymentSheetConfigurator(backendCheckoutUrl: backendCheckoutUrl)
           let amountInCents = Int(totalPrice * 100) // Convert to cents
           paymentSheetConfigurator.configurePaymentSheet(withAmount: amountInCents) { [weak self] paymentSheet in
               self?.paymentSheet = paymentSheet
               DispatchQueue.main.async {
                 //self?.payBtn.isEnabled = true
                   self?.payBtn.setTitle(String(format: "Confirm and Pay - A$ %.2f", Double(amountInCents)/100), for: .normal)
                 self?.payBtn.tintColor = UIColor.tintColor
                   
               }
           }
       }
   }
