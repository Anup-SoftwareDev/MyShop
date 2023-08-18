//
//  CartViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 8/8/2023.
//

import UIKit
import Firebase
import StripePaymentSheet

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var payBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var greetingLbl: UILabel!
    
    var paymentSheet: PaymentSheet?
    let backendCheckoutUrl = URL(string: "https://myshopbackend.onrender.com/payment-sheet")! // Your backend endpoint
    //let backendCheckoutUrl = URL(string: "http://localhost:3002/payment-sheet")! // Your backend endpoint
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the CartItemCell.xib
        let nib = UINib(nibName: "CartItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CartItemCell")
        
        // Set the delegate and dataSource for the tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Remove the lines between cells
        tableView.separatorStyle = .none
        setupGreetingLbl()
        
      
        payBtn.isEnabled = false
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
        greetingLbl.text = greetingManager.getGreeting()
    }
      
      // Number of sections
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      // Number of rows in section
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 3 // Three cells
      }
      
      // Create the cell for each row
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
          // Configure the cell as needed here
          return cell
      }
    


    private func configurePaymentSheet() {
        let paymentSheetConfigurator = PaymentSheetConfigurator(backendCheckoutUrl: backendCheckoutUrl)
        paymentSheetConfigurator.configurePaymentSheet(withAmount: 200) { [weak self] paymentSheet in
            self?.paymentSheet = paymentSheet
            DispatchQueue.main.async {
                self?.payBtn.isEnabled = true
            }
        }
    }

    
    
}
