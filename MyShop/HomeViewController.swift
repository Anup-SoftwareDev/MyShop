

import UIKit
import StripePaymentSheet

class HomeViewController: UIViewController {
    
    var paymentSheet: PaymentSheet?
    let backendCheckoutUrl = URL(string: "https://myshopbackend.onrender.com/payment-sheet")! // Your backend endpoint
    
    override func viewDidLoad() {
        print("Started..."  )
        super.viewDidLoad()
        configurePaymentSheet()
    }
    
    private func configurePaymentSheet() {
        let paymentSheetConfigurator = PaymentSheetConfigurator(backendCheckoutUrl: backendCheckoutUrl)
        paymentSheetConfigurator.configurePaymentSheet(withAmount: 200) { [weak self] paymentSheet in
            self?.paymentSheet = paymentSheet
            DispatchQueue.main.async {
                //self?.loginBtn.isEnabled = true
                print("Finished..." )
                self?.moveToNextScreen()
            }
            
        }
        
        
    }
    
    private func moveToNextScreen() {
        performSegue(withIdentifier: "toViewController", sender: self)
    }
}
