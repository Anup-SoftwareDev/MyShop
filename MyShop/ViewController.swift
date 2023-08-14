//
//  ViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 4/8/2023.
//

import UIKit
import Firebase
import StripePaymentSheet

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var cartBtn: UIBarButtonItem!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var greetingLbl: UILabel!
    
    var paymentSheet: PaymentSheet?
    let backendCheckoutUrl = URL(string: "https://myshopbackend.onrender.com/payment-sheet")! // Your backend endpoint

    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            loginBtn.titleLabel?.font = UIFont(name: "MarkerFelt", size: 16)
            configurePaymentSheet()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        let greetingManager = GreetingLabelManager()
        greetingLbl.text = greetingManager.getGreeting()
        
        if Auth.auth().currentUser != nil {
            loginBtn.setTitle("Logout", for: .normal)
        } else {
            loginBtn.setTitle("Log in", for: .normal)
        }
        
    }
    
    @IBAction func cartBtnClicked(_ sender: Any) {
       
        if Auth.auth().currentUser != nil {
                print("loggedIn")
                performSegue(withIdentifier: "toCart", sender: self)
            } else {
                print("not Logged in")
                let alert = UIAlertController(title: "Log in Required", message: "Need to Log in to view Cart Items", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                    self?.performSegue(withIdentifier: "toLogin", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
                // User is currently logged in, so log them out
                do {
                    try Auth.auth().signOut()
                    loginBtn.setTitle("Log in", for: .normal)
                    greetingLbl.text = "Hi Guest"
                } catch let error {
                    print("Error signing out: \(error.localizedDescription)")
                    // Optionally, you can show an alert to the user if the logout fails
                }
            } else {
                // User is not logged in, perform the segue to the login view controller
                performSegue(withIdentifier: "toLogin", sender: self)
            }
        
        
    }
    
        private func setupCollectionView() {
            // Register the xib for the collection view cell
            let nib = UINib(nibName: "ProductCellCVCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "ProductCellCVCell")
            
            // Set the collection view's data source and delegate
            collectionView.dataSource = self
            collectionView.delegate = self
        }

}

// MARK: - UICollectionViewDataSource
extension ViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // You mentioned you want it repeated 4 times
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellCVCell", for: indexPath) as! ProductCellCVCell
        // Configure cell if needed
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Define the size of your cell here
        return CGSize(width: 160, height: 220) // example size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // example spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // example spacing
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toProductDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductDetail", let destinationVC = segue.destination as? ProductDetailViewController {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            }
        }
    }
   

    private func configurePaymentSheet() {
        let paymentSheetConfigurator = PaymentSheetConfigurator(backendCheckoutUrl: backendCheckoutUrl)
        paymentSheetConfigurator.configurePaymentSheet { [weak self] paymentSheet in
            self?.paymentSheet = paymentSheet
           
        }
    }

    
}




