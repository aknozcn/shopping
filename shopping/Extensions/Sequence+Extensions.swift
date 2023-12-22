//
//  Sequence+Extensions.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import Foundation

extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}
