//
//  ViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 4/8/2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var cartBtn: UIBarButtonItem!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var greetingLbl: UILabel!
    
    //var cartItemIndexes = DataHolder.shared.cartIndexNumbers
    var cartItemIndexes: [Int] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        setupCollectionView()
            setupGreetingLbl()
            setupLoginBtnTitle()
            setupCartBadge()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        cartItemIndexes = []
        setupGreetingLbl()
        setupLoginBtnTitle()
        setupCartBadge()

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
        
        if Auth.auth().currentUser != nil {
                // User is currently logged in, so log them out
                do {
                    try Auth.auth().signOut()
                    loginBtn.setTitle("Log in", for: .normal)
                    greetingLbl.text = "Hi Guest"
                    DataHolder.shared.cartIndexNumbers = []
                    cartItemIndexes = []
                    cartBtn.removeBadge()
                    print( DataHolder.shared.cartIndexNumbers )                } catch let error {
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
    
    private func setupCartBadge() {
        obtainCartIndexes { [weak self] in
            guard let strongSelf = self else { return }
            
            if strongSelf.cartItemIndexes.count > 0 {
                print(strongSelf.cartItemIndexes.count)
                strongSelf.cartBtn.setBadge(with: strongSelf.cartItemIndexes.count)
            } else {
                strongSelf.cartBtn.removeBadge()
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
    
    private func setupLoginBtnTitle(){
        if Auth.auth().currentUser != nil {
            loginBtn.setTitle("Logout", for: .normal)
           
            
        } else {
            loginBtn.setTitle("Log in", for: .normal)
        }
    }
    
    private func obtainCartIndexes(completion: @escaping () -> Void){
        let database = Firestore.firestore()
        if let user = Auth.auth().currentUser, let email = user.email {
            let docRef = database.document("users/\(email)")
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else{
                    return
                }
               
                guard let cartNumbers = data["cart"] as? Array<Int> else {
                    return
                }
                print("Cart: \(cartNumbers)")
                self.cartItemIndexes = cartNumbers
                DataHolder.shared.cartIndexNumbers = cartNumbers

                completion()
            }
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8 // You mentioned you want it repeated 4 times
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellCVCell", for: indexPath) as! ProductCellCVCell
        // Configure cell if needed
        cell.configure(with: indexPath.row)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // Define the size of your cell here
        return CGSize(width: 160, height: 220) // example size
    }
 
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // example spacing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductDetail", let destinationVC = segue.destination as? ProductDetailViewController, let index = sender as? Int {
            destinationVC.productIndex = index
        }
    }

    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("You have clicked \(indexPath.row)")
            
            performSegue(withIdentifier: "toProductDetail", sender: indexPath.row)
    }

}




