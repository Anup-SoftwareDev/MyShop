//
//  CartViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 8/8/2023.
//

import UIKit
import Firebase
import StripePaymentSheet
import FirebaseFirestore
import FirebaseAuth

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CartItemCellDelegate{

    
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var greetingLbl: UILabel!
    @IBOutlet weak var cartItemCountLbl: UILabel!
    @IBOutlet weak var cartItemsPriceTotalLbl: UILabel!
    @IBOutlet weak var cartShippingFeeLbl: UILabel!
    @IBOutlet weak var cartProcessingFeeLbl: UILabel!
    @IBOutlet weak var cartFinalTotalLbl: UILabel!
    
    var cartItemIndexes: [Int] = []
    var cartItems: [[String: Any]] = []
    var cartItemsPriceTotal = 0.00
    var shippingfee = 0.00
    var processingfee = 0.00
    var cartItemPriceFeeTotal = 0.00
    
 
    
    var paymentSheet: PaymentSheet?
    let backendCheckoutUrl = URL(string: "https://myshopbackend.onrender.com/payment-sheet")!
   
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
        setupCartItems()
        payBtn.tintColor = UIColor.darkGray
        payBtn.setTitle("Please Wait. Loading Payment System ...", for: .normal)
        configurePaymentSheet()
        print(processingfee)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload the table view
        setupCartItems()
        tableView.reloadData()
 
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
            DataHolder.shared.cartIndexNumbers = []
            cartItems = []
            emptyCartDatabase()
            self.performSegue(withIdentifier: "toPaymentConfirmation", sender: self)
        case .canceled:
          print("Canceled!")
        case .failed(let error):
          print("Payment failed: \(error)")
        }
      }
        
    }
    
    private func emptyCartDatabase(){
        
        let database = Firestore.firestore()
        if let user = Auth.auth().currentUser, let email = user.email {
            let docRef = database.document("users/\(email)")
            let cartIndexNumbers = DataHolder.shared.cartIndexNumbers
            docRef.updateData(["cart": []])
            }
        }
    
    private func setupCartItems(){ 

        obtainCartIndexes()
        
        if cartItemIndexes.count == 0{
            print(processingfee)
            cartItems = []
            cartItemsPriceTotal = 0
            self.shippingfee = 0.00
            self.processingfee = 0.00
            payBtn.setTitle("CartEmpty - No Payments", for: .normal)
            
        }else{
            if cartItemIndexes.count == cartItems.count{
                return
            }else{
                self.shippingfee = 50.00
                self.processingfee = 25.00
                for index in cartItemIndexes {
                    
                    let product = ProductCellCVCell()
                    print("Product Index: \(product.imageNames[index])")
                    let item = [
                        "cartItemImage": product.imageNames[index],
                        "cartItemLbl": product.productNames[index],
                        "cartItemPrice": Double(product.productPrices[index])
                    ] as [String : Any]
                    cartItems.append(item)
                    cartItemsPriceTotal = cartItemsPriceTotal + product.productPrices[index]        }
            }
            
        }
        
       print("Cart Items: \(cartItems)")
        self.cartItemCountLbl.text = "Total (\(cartItemIndexes.count) item/s)"
        //self.cartItemsPriceTotalLbl.text = "A$ \(cartItemsPriceTotal)"
        self.cartItemsPriceTotalLbl.text = String(format: "AU $%.2f", cartItemsPriceTotal)
        self.cartShippingFeeLbl.text = String(format: "AU $%.2f", shippingfee)
        self.cartProcessingFeeLbl.text = String(format: "AU $%.2f", processingfee)
        self.cartItemPriceFeeTotal = cartItemsPriceTotal + shippingfee + processingfee
        self.cartFinalTotalLbl.text = String(format: "AU $%.2f", cartItemPriceFeeTotal)
    }
    
    
    private func obtainCartIndexes(){
        cartItemIndexes = DataHolder.shared.cartIndexNumbers

    }
    
    
    
    private func setupGreetingLbl(){
        let greetingManager = GreetingLabelManager()
        DispatchQueue.main.async {
            greetingManager.getGreeting{[self]greeting in
                self.greetingLbl.text = greeting
            }
        }
    }
      
      // Number of sections
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      // Number of rows in section
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          print("Count: \(cartItems.count)")
          //return cartItems.count
          return max(cartItems.count, 1)
          
      }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       

        // If the cart is empty
            if cartItems.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") ?? UITableViewCell(style: .default, reuseIdentifier: "EmptyCell")
                cell.textLabel?.text = "Cart is Empty"
                return cell
            }

            // If the cart has items
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as? CartItemCell {
               
                let cartItem = cartItems[indexPath.row]
                print("IndexPath.row: \(indexPath.row)")
                if let image = cartItem["cartItemImage"] as? String, let label = cartItem["cartItemLbl"] as? String, let price = cartItem["cartItemPrice"] as? Double, let index = indexPath.row as? Int
                {
                    cell.configureCell(with: image, label: label, price: price, index: index)
                    
                }
                cell.deleteButtonTapped = { [weak self] in
                    print("delete button closure executed")
                        self?.cartItems = []
                    self?.cartItemsPriceTotal = 0.00
                    self?.cartItemPriceFeeTotal = 0.00
                        self?.setupCartItems()
                    self?.shippingfee = 0.00
                    self?.processingfee = 0.00
                        tableView.reloadData()
                    self?.configurePaymentSheet()
                        }
                cell.delegate = self
                return cell
            }

            return UITableViewCell() // Fallback
        
    }



    private func configurePaymentSheet() {
        let paymentSheetConfigurator = PaymentSheetConfigurator(backendCheckoutUrl: backendCheckoutUrl)
        let amountInCents = Int(cartItemPriceFeeTotal * 100)
        print("amount in cents: \(amountInCents)")
        paymentSheetConfigurator.configurePaymentSheet(withAmount: amountInCents) { [weak self] paymentSheet in
            self?.paymentSheet = paymentSheet
            DispatchQueue.main.async {
                //self?.payBtn.isEnabled = true;
                self?.payBtn.setTitle(String(format: "Confirm and Pay - AU $%.2f", Double(amountInCents)/100), for: .normal)
                self?.payBtn.tintColor = UIColor.tintColor
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCartProductDetail",
           let destinationVC = segue.destination as? CartProductDetailViewController,
           let cell = sender as? CartItemCell {
            //destinationVC.productIndex = 5
            // if you want to pass dynamic index based on tapped cell you can do the following
            let indexPath = tableView.indexPath(for: cell)
            //destinationVC.productIndex = indexPath?.row
            destinationVC.productIndex = cartItemIndexes[indexPath!.row]
            }
        }
        

    func didTapOnCellContent(cell: CartItemCell) {
        performSegue(withIdentifier: "toCartProductDetail", sender: cell)
    }

    
}
