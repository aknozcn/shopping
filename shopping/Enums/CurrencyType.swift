//
//  CurrencyType.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

enum CurrencyType: String, CaseIterable {
    case TL = "₺"
    case USD = "$"
    case EUR = "€"
    
    var symbol: String {
        return self.rawValue
    }
}
