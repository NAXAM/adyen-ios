//
// Copyright (c) 2018 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

/// An object that represents a payment that has been completed by the user. The result of the payment can be retrieved via the `status` property.
@objc public final class Payment : NSObject {
    
    // MARK: - Initializing
    
    internal init(status: PaymentStatus, method: PaymentMethod, payload: String, paymentSetup: PaymentSetup) {
        self.status = status
        self.method = method
        self.payload = payload
        self.amount = paymentSetup.amount
        self.currencyCode = paymentSetup.currencyCode
        self.merchantReference = paymentSetup.merchantReference
        self.shopperReference = paymentSetup.shopperReference
        self.shopperCountryCode = paymentSetup.countryCode
        self.shopperLocaleIdentifier = paymentSetup.shopperLocaleIdentifier
    }
    
    // MARK: - Accessing the Status of Completed Payment
    
    /// The status of the payment.
    public let status: PaymentStatus
    
    
    @objc public var paymentStatus: String {
        get {
            return status.rawValue
        }
    }
    
    // MARK: - Accessing the Info Used to Complete Payment
    
    /// The method that was used to complete the payment.
    @objc public let method: PaymentMethod
    
    /// The payload as returned from the server.
    @objc public let payload: String
    
    /// The amount of the payment, in minor units.
    @objc public let amount: Int
    
    /// The code of the currency for the payment amount.
    @objc public let currencyCode: String
    
    /// The reference of the merchant.
    @objc public let merchantReference: String
    
    /// The reference of the shopper.
    @objc public let shopperReference: String?
    
    /// The country code of the shopper.
    @objc public let shopperCountryCode: String
    
    /// The locale identifier of the shopper.
    @objc public let shopperLocaleIdentifier: String?
}
