//
//  BasketManager.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import Foundation
import Toast

final class BasketManager {

    static let shared = BasketManager()
    private init() { }

    private var products: [Product] = []

    func addProduct(product: Product) {
        guard !isProductInBasket(product) else {
            showToast(with: "Ürün sepette mevcut.")
            return
        }

        products.append(product)
        showToast(with: "Ürün sepete eklendi.")
    }

    func getProducts() -> [Product] {
        return products
    }

    func removeProduct(id: Int) {
        products.removeAll(where: { $0.id == id })
    }

    func removeAll() {
        products.removeAll()
    }
}

private extension BasketManager {
    func showToast(with message: String) {
        Toast.text(message).show()
    }

    func isProductInBasket(_ product: Product) -> Bool {
        return products.contains { $0.id == product.id }
    }
}
