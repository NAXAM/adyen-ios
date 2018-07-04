//
//  PaymentRequestDelegateBridge.swift
//  Adyen
//
//  Created by Tuyen Vu Duc on 7/3/18.
//  Copyright © 2018 Adyen. All rights reserved.
//

import Foundation

internal class PaymentRequestDelegateBridge: NSObject, PaymentRequestDelegate {
    private weak var delegate: PaymentRequestDelegateBridgeDelegate?
    
    public init(delegate: PaymentRequestDelegateBridgeDelegate) {
        self.delegate = delegate
    }
    
    public func paymentRequest(_ request: PaymentRequest, requiresPaymentDataForToken token: String, completion: @escaping DataCompletion) {
        self.delegate?.paymentRequest(request, requiresPaymentDataForToken: token, completion: completion)
    }
    
    public func paymentRequest(_ request: PaymentRequest, requiresPaymentMethodFrom preferredMethods: [PaymentMethod]?, available availableMethods: [PaymentMethod], completion: @escaping MethodCompletion) {
        self.delegate?.paymentRequest(request, requiresPaymentMethodFrom: preferredMethods, available: availableMethods, completion: completion)
    }
    
    public func paymentRequest(_ request: PaymentRequest, requiresReturnURLFrom url: URL, completion: @escaping URLCompletion) {
        self.delegate?.paymentRequest(request, requiresReturnURLFrom: url, completion: completion)
    }
    
    public func paymentRequest(_ request: PaymentRequest, requiresPaymentDetails details: PaymentDetails, completion: @escaping PaymentDetailsCompletion) {
        self.delegate?.paymentRequest(request, requiresPaymentDetails: details, completion: completion)
    }
    
    public func paymentRequest(_ request: PaymentRequest, didFinishWith result: PaymentRequestResult) {
        switch result {
        case .payment(let payment):
            self.delegate?.paymentRequest(request, didFinishWith: payment, error: nil)
        case .error(let error):
            self.delegate?.paymentRequest(request, didFinishWith: nil, error: NSError(domain: error.errorDescription!, code: 0, userInfo: nil))
        }
    }
}

@objc public protocol PaymentRequestDelegateBridgeDelegate {
    /// Given the `PaymentRequest` that started the payment flow and `token`, waits for data from merchant server to be passed via `completion`.
    func paymentRequest(_ request: PaymentRequest, requiresPaymentDataForToken token: String, completion: @escaping DataCompletion)
    
    /// Given a list of `PaymentMethod` (available and preferred) waits for the selection via `completion`.
    func paymentRequest(_ request: PaymentRequest, requiresPaymentMethodFrom preferredMethods: [PaymentMethod]?, available availableMethods: [PaymentMethod], completion: @escaping MethodCompletion)
    
    /// This method is called when a URL redirection needs to be executed.
    /// `url` can be a universal link, an app URL, or a standard URL that is to be opened in Safari or `SFSafariViewController`
    /// Care should be taken when handling an app URL, as this type of URL will not have the http/https scheme, and will cause a crash if opened in `SFSafariViewController`.
    /// After the process is completed, the `completion` for the given URL must be called.
    func paymentRequest(_ request: PaymentRequest, requiresReturnURLFrom url: URL, completion: @escaping URLCompletion)
    
    /// This method is called when input is needed for completing the transation. The filled `PaymentDetails` should be sent via `completion`.
    func paymentRequest(_ request: PaymentRequest, requiresPaymentDetails details: PaymentDetails, completion: @escaping PaymentDetailsCompletion)
    
    /// This method is called when the payment flow is finished.
    func paymentRequest(_ request: PaymentRequest, didFinishWith result: Payment?, error: NSError?)
}
