//
//  File.swift
//  MyShop
//
//  Created by Anup Kuriakose on 14/8/2023.
//

import Foundation
import FirebaseAuth

class GreetingLabelManager {
    func getGreeting() -> String {
        if let user = Auth.auth().currentUser, let email = user.email, let range = email.range(of: "@") {
            var name = String(email[..<range.lowerBound])
            name = name.prefix(1).capitalized + name.dropFirst()
            return "Hi \(name)"
        } else {
            return "Hi Guest"
        }
    }
}

