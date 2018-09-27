//
// Copyright (c) 2018 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

// Fill in your app identifier and secret key here.
struct Configuration {
    static var appSecretKey = "0101388667EE5CD5932B441CFA248493772CA2EB8E5CAC5F02865A157153D56CE6AA67588AC27905D2492DADF0CB2570C9E373FD29B78FE758EA9E10C15D5B0DBEE47CDCB5588C48224C6007"
    
    static var isFilledIn: Bool {
        return appSecretKey.isEmpty == false
    }
    
    // Checks if SecretKey was defined in compile time via SECRET_KEY user defined build setting.
    static func readApiKeyFromUserDefinedBuildSettings() {
        if let apiKey = Bundle.init(for: AppDelegate.self).object(forInfoDictionaryKey: "SecretKey") as? String,
            apiKey.isEmpty == false {
            Configuration.appSecretKey = apiKey
        }
    }
}
