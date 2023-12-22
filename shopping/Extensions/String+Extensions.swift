//
//  String+Extensions.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import Foundation

extension String {
    func getSymbol() -> String {
        guard let currency = CurrencyType.allCases.first(where: { "\($0)" == self }) else {
            return ""
        }
        return currency.symbol
    }
}
