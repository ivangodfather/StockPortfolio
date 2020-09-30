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
            return "Tsk_cd99e8f9d4304232b8cc116b6272e678"
        #else
            return "sk_b14e59bb5a5e47e79ac31a0d2e36e739"
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
