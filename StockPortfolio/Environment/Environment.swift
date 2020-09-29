//
//  Environment.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct EnvironmentValue {
    static var iexToken: String {
        #if DEBUG
            return "Tsk_273876ee338444daa21d9f1465b2dc11"
        #else
            return "sk_48bb8938172f46ecbd229023add18561"
        #endif
    }

    static var iexHost: String {
        #if DEBUG
            return "sandbox.iexapis.com"
        #else
            return "cloud.iexapis.com"
        #endif
    }
}
