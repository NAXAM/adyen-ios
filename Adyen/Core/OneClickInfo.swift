//
// Copyright (c) 2018 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

/// Instances conforming to this protocol provide access to the information that was stored for a payment method.
@objc public protocol OneClickInfo {
    
}

/// Object that contains stored card info used to perform previous card payments.
@objc public class CardOneClickInfo: NSObject, OneClickInfo {
    
    public init(
        number: String,
        holderName: String,
        expiryMonth: Int,
        expiryYear: Int
        ){
        self.number = number
        self.holderName = holderName
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
    }
    
    // MARK: - Accessing Stored Info
    
    /// A shortened version of the card's number.
    @objc public let number: String
    
    /// The card's holder name.
    @objc public let holderName: String
    
    /// The card's expiry month.
    @objc public let expiryMonth: Int
    
    /// The card's expiry year.
    @objc public let expiryYear: Int
    
    internal init?(dictionary: [String: Any]) {
        guard
            let number = dictionary["number"] as? String,
            let holderName = dictionary["holderName"] as? String,
            let expiryMonthString = dictionary["expiryMonth"] as? String,
            let expiryYearString = dictionary["expiryYear"] as? String,
            let expiryMonth = Int(expiryMonthString),
            let expiryYear = Int(expiryYearString)
        else {
            return nil
        }
        
        self.number = number
        self.holderName = holderName
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
    }
    
}

/// Object that contains stored info used to perform previous PayPal payments.
@objc public class PayPalOneClickInfo: NSObject, OneClickInfo {
    public init(emailAddress: String) {
        self.emailAddress = emailAddress
    }
    
    // MARK: - Accessing Stored Info
    
    /// The email address of the PayPal account.
    @objc public let emailAddress: String
    
}
