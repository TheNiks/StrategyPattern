//
//  ViewController.swift
//  PaymentApp
//
//  Created by Nikunj Modi on 29/12/24.
//

import UIKit
import PassKit

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Example: Use the payment handler
        let selectedMethod: PaymentMethod = .creditCard // Assume user selected Credit Card
        let paymentAmount: Double = 150.00
        
        handlePayment(method: selectedMethod, amount: paymentAmount) { success, message in
            if success {
                // Show success message
                print("Success: \(message)")
                self.showAlert(title: "Payment Successful", message: message)
            } else {
                // Show failure message
                print("Failure: \(message)")
                self.showAlert(title: "Payment Failed", message: message)
            }
        }
    }
    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
    }

    func handlePayment(method: PaymentMethod, amount: Double, completion: @escaping (Bool, String) -> Void) {
        switch method {
        case .creditCard:
            processCreditCardPayment(amount: amount, completion: completion)
            
        case .applePay:
            processApplePayPayment(amount: amount, completion: completion)
            
        case .paypal:
            processPayPalPayment(amount: amount, completion: completion)
        }
    }
    
    func processCreditCardPayment(amount: Double, completion: @escaping (Bool, String) -> Void) {
        // Example: Integrating with a payment gateway like Stripe
        print("Processing credit card payment of $\(amount)...")
        
        // Simulate a network call to a payment gateway (e.g., Stripe)
        DispatchQueue.global().async {
            // Simulate network delay
            sleep(2)
            
            // Simulate a success or failure response
            let success = Bool.random()
            
            DispatchQueue.main.async {
                if success {
                    completion(true, "Credit card payment successful")
                } else {
                    completion(false, "Credit card payment failed")
                }
            }
        }
    }
    
    
    func processApplePayPayment(amount: Double, completion: @escaping (Bool, String) -> Void) {
        // Example: Handling an Apple Pay payment
        print("Processing Apple Pay payment of $\(amount)...")
        
        // Check if Apple Pay is available
        if PKPaymentAuthorizationViewController.canMakePayments() {
            // Simulate creating a payment request and authorizing payment
            let paymentRequest = PKPaymentRequest()
            paymentRequest.merchantIdentifier = "your.merchant.id"
            paymentRequest.supportedNetworks = [.visa, .masterCard, .amex]
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.countryCode = "US"
            paymentRequest.currencyCode = "USD"
            
            // Simulate the payment processing flow
            DispatchQueue.global().async {
                sleep(2) // Simulate network delay
                
                let success = Bool.random() // Simulate success or failure
                
                DispatchQueue.main.async {
                    if success {
                        completion(true, "Apple Pay payment successful")
                    } else {
                        completion(false, "Apple Pay payment failed")
                    }
                }
            }
        } else {
            completion(false, "Apple Pay not available on this device")
        }
    }
    
    func processPayPalPayment(amount: Double, completion: @escaping (Bool, String) -> Void) {
        // Example: Integrating with PayPal API via Braintree or PayPal SDK
        print("Processing PayPal payment of $\(amount)...")
        
        // Simulate a network request to PayPal's payment gateway
        DispatchQueue.global().async {
            // Simulate network delay
            sleep(2)
            
            // Simulate a PayPal payment success or failure
            let success = Bool.random()
            
            DispatchQueue.main.async {
                if success {
                    completion(true, "PayPal payment successful")
                } else {
                    completion(false, "PayPal payment failed")
                }
            }
        }
    }
}

