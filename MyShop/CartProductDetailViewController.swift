

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class CartProductDetailViewController: UIViewController {
  
        var productIndex: Int?
        var product = ProductCellCVCell()
        var cartIndexNumbers: [Int] = DataHolder.shared.cartIndexNumbers
        
     
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var productLbl: UILabel!
        @IBOutlet weak var priceLbl: UILabel!
        @IBOutlet weak var productDescription: UITextView!
        @IBOutlet weak var cartBtn: UIBarButtonItem!
        @IBOutlet weak var greetingLbl: UILabel!
        @IBOutlet weak var backToCartBtn: UIButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpCartBadge()
            setUpGreetingLbl()
            setUpProductDetails()

        }
        
        override func viewDidAppear(_ animated: Bool) {
            //let cartItemIndexes = DataHolder.shared.cartIndexNumbers
            setUpCartBadge()
            setUpGreetingLbl()
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toBuy",
               let destinationVC = segue.destination as? BuyNowViewController {
                if let index = productIndex {
                    destinationVC.index = index
                }
            }
        }
        

    @IBAction func cartBtnClicked(_ sender: Any) {
        handleActionIfAuthenticated(segueIfAuthenticated: "toCart", alertMessage: "Need to Log in to view Cart Items")
        
    }
    

    @IBAction func backToCartBtnClicked(_ sender: Any) {
        
        handleActionIfAuthenticated(segueIfAuthenticated: "toCart", alertMessage: "Need to Log in to view Cart Items")
    }

        
        
        /////////////////////////////////////////////////////////////////////////////////
        // Call Functions to simplify code above//////
        ///////////////////////////////////////////////////////////////////////////////////

        
        private func addIndexToDatabase(){
            
            let database = Firestore.firestore()
            if let user = Auth.auth().currentUser, let email = user.email {
                let docRef = database.document("users/\(email)")
                cartIndexNumbers = DataHolder.shared.cartIndexNumbers
                docRef.updateData(["cart": cartIndexNumbers])
                }
            
            }
        
        private func setUpCartBadge(){
            cartIndexNumbers = DataHolder.shared.cartIndexNumbers
            if cartIndexNumbers.count > 0{
                print(cartIndexNumbers.count)
                cartBtn.setBadge(with: cartIndexNumbers.count)
            }else{
                cartBtn.removeBadge()
            }
            
        }
        
        private func setUpGreetingLbl() {
            let greetingManager = GreetingLabelManager()
            //greetingLbl.text = greetingManager.getGreeting()
            DispatchQueue.main.async {
                greetingManager.getGreeting{[self]greeting in
                    self.greetingLbl.text = greeting
                }
            }
            
        }
        
        private func setUpProductDetails(){
            imageView.image = UIImage(named: product.imageNames[productIndex!])
            productLbl.text = product.productNames[productIndex!]
            priceLbl.text = "\(String(format: "A$ %.2f", product.productPrices[productIndex!]))"
           
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
