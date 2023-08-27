//
//  PaymentConfirmationViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 13/8/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PaymentConfirmationViewController: UIViewController {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    var database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser, let email = user.email {
            let docRef = database.document("users/\(email)")
            docRef.getDocument { snapshot, error in
                if let data = snapshot?.data(), error == nil, let name = data["name"] as? String {
                    print("Hi \(name.capitalized)")
                    self.nameLbl.text = "\(name.capitalized)!"
                }
            }
            
        }
        
    }
}
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class GreetingLabelManager {
//
//    var database = Firestore.firestore()
//
//
//    func getGreeting(completion: @escaping (String) -> Void) {
//        if let user = Auth.auth().currentUser, let email = user.email {
//            let docRef = database.document("users/\(email)")
//            docRef.getDocument { snapshot, error in
//                if let data = snapshot?.data(), error == nil, let name = data["name"] as? String {
//                    completion("Hi \(name.capitalized)")
//                } else {
//                    completion("Hi Guest")
//                }
//            }
//        } else {
//            completion("Hi Guest")
//        }
//    }
//
//}
