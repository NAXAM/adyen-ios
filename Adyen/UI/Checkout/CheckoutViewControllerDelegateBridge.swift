//
//  CheckoutViewControllerDelegateBridge.swift
//  Adyen
//
//  Created by Tuyen Vu Duc on 7/3/18.
//  Copyright © 2018 Adyen. All rights reserved.
//

import Foundation

internal class CheckoutViewControllerDelegateBridge: NSObject, CheckoutViewControllerDelegate {
    private weak var delegate: CheckoutViewControllerDelegateBridgeDelegate?
    
    public init(delegate: CheckoutViewControllerDelegateBridgeDelegate) {
        self.delegate = delegate
    }
    
    /// Invoked when the payment flow has started and payment data is requested from the merchant server.
    ///
    /// - Parameters:
    ///   - controller: The checkout view controller that has started the payment flow.
    ///   - token: The token assigned to the payment flow.
    ///   - completion: The completion handler to invoke when the payment data is retrieved from the merchant server.
    public func checkoutViewController(_ controller: CheckoutViewController, requiresPaymentDataForToken token: String, completion: @escaping DataCompletion) {
        self.delegate?.checkoutViewController(controller, requiresPaymentDataForToken: token, completion: completion)
    }
    
    /// Invoked when the redirection to a URL has been made. The given completion handler should be invoked when the user returns to the application through a URL.
    ///
    /// - Parameters:
    ///   - controller: The checkout view controller which requested the return from a URL redirection.
    ///   - completion: The completion handler to invoke when the user returns to the application through a URL.
    public func checkoutViewController(_ controller: CheckoutViewController, requiresReturnURL completion: @escaping URLCompletion) {
        self.delegate?.checkoutViewController(controller, requiresReturnURL: completion)
    }
    
    /// Invoked when the payment flow has finished.
    ///
    /// - Parameters:
    ///   - controller: The checkout view controller that finished the payment flow.
    ///   - result: The payment result.
    public func checkoutViewController(_ controller: CheckoutViewController, didFinishWith result: PaymentRequestResult) {
        switch result {
        case .payment(let payment):
            self.delegate?.checkoutViewController(controller, didFinishWith: payment, error: nil)
        case .error(let error):
            self.delegate?.checkoutViewController(controller, didFinishWith: nil, error: NSError(domain: error.errorDescription!, code: 0, userInfo: nil))
        }
    }
}

@objc public protocol CheckoutViewControllerDelegateBridgeDelegate {
    /// Invoked when the payment flow has started and payment data is requested from the merchant server.
    ///
    /// - Parameters:
    ///   - controller: The checkout view controller that has started the payment flow.
    ///   - token: The token assigned to the payment flow.
    ///   - completion: The completion handler to invoke when the payment data is retrieved from the merchant server.
    func checkoutViewController(_ controller: CheckoutViewController, requiresPaymentDataForToken token: String, completion: @escaping DataCompletion)
    
    /// Invoked when the redirection to a URL has been made. The given completion handler should be invoked when the user returns to the application through a URL.
    ///
    /// - Parameters:
    ///   - controller: The checkout view controller which requested the return from a URL redirection.
    ///   - completion: The completion handler to invoke when the user returns to the application through a URL.
    func checkoutViewController(_ controller: CheckoutViewController, requiresReturnURL completion: @escaping URLCompletion)
    
    /// Invoked when the payment flow has finished.
    ///
    /// - Parameters:
    ///   - controller: The checkout view controller that finished the payment flow.
    ///   - result: The payment result.
    func checkoutViewController(_ controller: CheckoutViewController, didFinishWith result: Payment?, error: NSError?)
}
