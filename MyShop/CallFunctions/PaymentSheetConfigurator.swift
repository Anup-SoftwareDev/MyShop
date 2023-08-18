//
//  PaymentSheetConfigurator.swift
//  MyShop
//
//  Created by Anup Kuriakose on 14/8/2023.
//

//import Foundation
//import StripePaymentSheet
//
//class PaymentSheetConfigurator {
//    private let backendCheckoutUrl: URL
//
//    init(backendCheckoutUrl: URL) {
//        self.backendCheckoutUrl = backendCheckoutUrl
//    }
//
//    func configurePaymentSheet(completion: @escaping (PaymentSheet?) -> Void) {
//        var request = URLRequest(url: backendCheckoutUrl)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = Data()
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                  let customerId = json["customer"] as? String,
//                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
//                  let paymentIntentClientSecret = json["paymentIntent"] as? String,
//                  let publishableKey = json["publishableKey"] as? String else {
//                // Handle error
//                return
//            }
//
//            STPAPIClient.shared.publishableKey = publishableKey
//            var configuration = PaymentSheet.Configuration()
//            configuration.merchantDisplayName = "Example, Inc."
//            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
//            configuration.allowsDelayedPaymentMethods = true
//            let paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
//
//            completion(paymentSheet)
//        }
//        task.resume()
//    }
//}

import Foundation
import StripePaymentSheet

class PaymentSheetConfigurator {
    private let backendCheckoutUrl: URL

    init(backendCheckoutUrl: URL) {
        self.backendCheckoutUrl = backendCheckoutUrl
    }
    
    func configurePaymentSheet(withAmount amount: Int, completion: @escaping (PaymentSheet?) -> Void) {
        print("amount: \(amount)")
        var request = URLRequest(url: backendCheckoutUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["amount": amount]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        //request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let customerId = json["customer"] as? String,
                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                  let paymentIntentClientSecret = json["paymentIntent"] as? String,
                  let publishableKey = json["publishableKey"] as? String else {
                // Handle error
                return
            }
            print("data: \(data)")
            print("request: \(request)")
            print("request.httpBody: \(request.httpBody!)")
            STPAPIClient.shared.publishableKey = publishableKey
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Example, Inc."
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.allowsDelayedPaymentMethods = true
            let paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
            
            completion(paymentSheet)
        }
        task.resume()
    }
}
