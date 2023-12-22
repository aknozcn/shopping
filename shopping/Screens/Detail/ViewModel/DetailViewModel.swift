//
//  DetailViewModel.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    func viewDidLoad()
    func addProduct()
    func updateLikedProduct()
    var product: Product { get }
    var currency: String { get }
}

protocol DetailViewModelDelegate: AnyObject {
    func setUI()
    func setTitle(_ title: String)
    func setLikeButtonImage(isLiked: Bool)
}

final class DetailViewModel: DetailViewModelProtocol {
    weak var delegate: DetailViewModelDelegate?

    var product: Product

    var currency: String {
        return product.currency.getSymbol()
    }

    init(product: Product) {
        self.product = product
    }

    func viewDidLoad() {
        delegate?.setUI()
        delegate?.setTitle("Product Detail")
        checkIsLiked()
    }
    
    func addProduct() {
        BasketManager.shared.addProduct(product: product)
    }
    
    func checkIsLiked() {
        let isLiked = FavoritesManager.shared.isProductFavorite(id: product.id)
        delegate?.setLikeButtonImage(isLiked: isLiked)
    }
    
    func updateLikedProduct() {
        let isLiked = FavoritesManager.shared.isProductFavorite(id: product.id)
        if isLiked {
            FavoritesManager.shared.unFavoriteProduct(id: product.id)
        } else {
            FavoritesManager.shared.favoriteProduct(id: product.id)
        }
        delegate?.setLikeButtonImage(isLiked: !isLiked)
    }
}
