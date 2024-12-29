# StrategyPattern
The Strategy Pattern is a behavioral design pattern that defines a family of algorithms, encapsulates each one, and makes them interchangeable. The client code (or context) can choose the strategy (algorithm) to execute at runtime, and the same interface is used for all strategies.

In POP, we won't have objects or inheritance, but we can still define function pointers to simulate polymorphic behavior.

Summary
Protocol: PaymentMethodProtocol defines a common interface for all payment methods.
Concrete Classes: Each payment method (credit card, Apple Pay, PayPal) is represented by its own class that implements processPayment.
Polymorphism: We instantiate the appropriate payment method and call processPayment, without needing to switch on payment type, thus removing conditional logic in favor of polymorphism.
