//
//  Environment.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct EnvironmentValue {
    static var iexToken: String {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
           let dictionary = NSDictionary(contentsOfFile: path) {
            #if DEBUG
            return dictionary["IEXSandboxSecret"] as! String
            #else
            return dictionary["IEXSecret"] as! String
            #endif

        }
        fatalError("You should provide a valid token here (iexcloud.com)")
    }

    static var iexHost: String {
        #if DEBUG
            return "sandbox.iexapis.com"
        #else
            return "cloud.iexapis.com"
        #endif
    }
}
