//
//  ConfirmationViewModel.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import Foundation

protocol ConfirmationViewModelProtocol {
    func viewDidLoad()
    func clear()
    var itemCount: String { get }
    var totalAmount: String { get }
}

protocol ConfirmationViewModelDelegate: AnyObject {
    func setUI()
    func setTitle(_ title: String)
    func navigateToList()
}

final class ConfirmationViewModel: ConfirmationViewModelProtocol {
    weak var delegate: ConfirmationViewModelDelegate?

    var itemCount: String {
        return "\(BasketManager.shared.getProducts().count)"
    }

    var totalAmount: String {
        let formattedPrice = String(format: "%.2f", BasketManager.shared.getProducts().sum(\.price))
        return "\(CurrencyType.USD.symbol)\(formattedPrice)"
    }
    
    func viewDidLoad() {
        delegate?.setUI()
        delegate?.setTitle("Order Confirmation")
    }
    
    func clear() {
        BasketManager.shared.removeAll()
        FavoritesManager.shared.removeAll()
        delegate?.navigateToList()
    }
}
