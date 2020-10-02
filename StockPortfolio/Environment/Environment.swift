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
        return ["Tsk_7457f19f5e3742a19e8e529587924528", "Tsk_273876ee338444daa21d9f1465b2dc11", "Tsk_cd99e8f9d4304232b8cc116b6272e678"].randomElement()!
        #else
        return ["sk_b39a7c233b3c4c05954c17283558bde6", "sk_48bb8938172f46ecbd229023add18561", "sk_b14e59bb5a5e47e79ac31a0d2e36e739"].randomElement()!
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
