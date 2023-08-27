//
//  CartBtnBadge.swift
//  MyShop
//
//  Created by Anup Kuriakose on 21/8/2023.
//

import Foundation
import UIKit
import Firebase

extension UIBarButtonItem {
    
    private var badgeIdentifier: String {
            return "UIBarButtonItemBadge"
        }
    
    func setBadge(with value: Int) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        // Remove previous badge if any
        removeBadge()
        
        let badgeLabel = UILabel()
        badgeLabel.text = "\(value)"
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = .white
        badgeLabel.textColor = .red
        badgeLabel.font = UIFont.systemFont(ofSize: 12)
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.frame = CGRect(x: view.frame.width - 15, y: 0, width: 20, height: 20)
        
        // Set an accessibility identifier to the badgeLabel to find it later
        badgeLabel.accessibilityIdentifier = badgeIdentifier
        view.addSubview(badgeLabel)
    }
    
    func removeBadge() {
            guard let view = self.value(forKey: "view") as? UIView else { return }
            
            // Find the badgeLabel by its identifier and remove it
            view.subviews.forEach { subview in
                if subview.accessibilityIdentifier == badgeIdentifier {
                    subview.removeFromSuperview()
                }
            }
        }
  
}

//class DataHolder {
//    static let shared = DataHolder()
//    var cartIndexNumbers: [Int] = []
//    let database = Firestore.firestore()
//
//    if let user = Auth.auth().currentUser, let email = user.email {
//        let docRef = database.document("users/\(email)")
//        docRef.getDocument { snapshot, error in
//            guard let data = snapshot?.data(), error == nil else{
//                           return
//                       }
//
//            guard let cart = data["cart"] as? Array<Int> else {
//                           return
//                       }
//            print("Cart: \(cart)")
//            cartIndexNumbers = cart
//        }
//    }
//
//    private init() {} // This prevents others from using the default '()' initializer
//}

class DataHolder {
    static let shared = DataHolder()
    var cartIndexNumbers: [Int] = []
    //let database = Firestore.firestore()
    
    private init() {
//        if let user = Auth.auth().currentUser, let email = user.email {
//            let docRef = database.document("users/\(email)")
//            docRef.getDocument { snapshot, error in
//                guard let data = snapshot?.data(), error == nil else{
//                    return
//                }
//
//                guard let cart = data["cart"] as? [Int] else {
//                    return
//                }
//                print("Cart: \(cart)")
//                self.cartIndexNumbers = cart
//            }
//        }
    }
}






