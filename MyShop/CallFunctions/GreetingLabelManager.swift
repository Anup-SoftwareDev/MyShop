//
//  File.swift
//  MyShop
//
//  Created by Anup Kuriakose on 14/8/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class GreetingLabelManager {
    
    var database = Firestore.firestore()

    
    func getGreeting(completion: @escaping (String) -> Void) {
        if let user = Auth.auth().currentUser, let email = user.email {
            let docRef = database.document("users/\(email)")
            docRef.getDocument { snapshot, error in
                if let data = snapshot?.data(), error == nil, let name = data["name"] as? String {
                    completion("Hi \(name.capitalized)")
                } else {
                    completion("Hi Guest")
                }
            }
        } else {
            completion("Hi Guest")
        }
    }
        
}

