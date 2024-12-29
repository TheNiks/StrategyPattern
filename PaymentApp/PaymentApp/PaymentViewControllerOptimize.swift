//
//  PaymentViewControllerOptimize.swift
//  PaymentApp
//
//  Created by Nikunj Modi on 29/12/24.
//


//Optimisation UIViewController Code

import Foundation
import UIKit
import PassKit

protocol PaymentMethodProtocol {
    func processPayment(amount: Double, completion: @escaping (Bool, String) -> Void)
}


class PaymentViewControllerOptimize: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Example usage with polymorphism
        let selectedPaymentMethod: PaymentMethodProtocol = CreditCardPayment()  // You can dynamically change this
        let paymentAmount: Double = 150.00
        
        handlePayment(paymentMethod: selectedPaymentMethod, amount: paymentAmount)
    }
    
    func handlePayment(paymentMethod: PaymentMethodProtocol, amount: Double) {
        paymentMethod.processPayment(amount: amount) { success, message in
            if success {
                print("Payment Successful: \(message)")
                self.showAlert(title: "Payment Successful", message: message)
            } else {
                print("Payment Failed: \(message)")
                self.showAlert(title: "Payment Failed", message: message)
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

class CreditCardPayment: PaymentMethodProtocol {
    func processPayment(amount: Double, completion: @escaping (Bool, String) -> Void) {
        // Simulate processing a credit card payment
        print("Processing credit card payment of $\(amount)...")
        
        // Simulate network call and payment success or failure
        DispatchQueue.global().async {
            sleep(2) // Simulate network delay
            let success = Bool.random() // Simulate success/failure randomly
            DispatchQueue.main.async {
                if success {
                    completion(true, "Credit card payment successful")
                } else {
                    completion(false, "Credit card payment failed")
                }
            }
        }
    }
}


class ApplePayPayment: PaymentMethodProtocol {
    func processPayment(amount: Double, completion: @escaping (Bool, String) -> Void) {
        // Simulate processing Apple Pay payment
        print("Processing Apple Pay payment of $\(amount)...")
        
        // Check if Apple Pay is available
        if PKPaymentAuthorizationViewController.canMakePayments() {
            DispatchQueue.global().async {
                sleep(2) // Simulate network delay
                
                let success = Bool.random() // Simulate success/failure randomly
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
}

class PayPalPayment: PaymentMethodProtocol {
    func processPayment(amount: Double, completion: @escaping (Bool, String) -> Void) {
        // Simulate processing PayPal payment
        print("Processing PayPal payment of $\(amount)...")
        
        DispatchQueue.global().async {
            sleep(2) // Simulate network delay
            
            let success = Bool.random() // Simulate success/failure randomly
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

