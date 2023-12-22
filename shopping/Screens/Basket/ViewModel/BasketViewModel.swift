//
//  BasketViewModel.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import Foundation

protocol BasketViewModelProtocol {
    func viewDidLoad()
    func checkBasketIsNotEmpty()
    var itemCount: String { get }
    var totalAmount: String { get }
}

protocol BasketViewModelDelegate: AnyObject {
    func getProductList(products: [Product])
    func setTitle(_ title: String)
    func setUI()
    func updateCheckOutButton(isEnable: Bool)
}

final class BasketViewModel: BasketViewModelProtocol {
    weak var delegate: BasketViewModelDelegate?

    var itemCount: String {
        return "\(BasketManager.shared.getProducts().count)"
    }

    var totalAmount: String {
        let formattedPrice = String(format: "%.2f", BasketManager.shared.getProducts().sum(\.price))
        return "\(CurrencyType.USD.symbol)\(formattedPrice)"
    }

    func viewDidLoad() {
        delegate?.setTitle("Shopping Bag")
        getProducts()
        delegate?.setUI()
    }
    
    func checkBasketIsNotEmpty() {
        delegate?.updateCheckOutButton(isEnable: BasketManager.shared.getProducts().count > 0)
    }
}

private extension BasketViewModel {
    func getProducts() {
        delegate?.getProductList(products: BasketManager.shared.getProducts())
    }
}
