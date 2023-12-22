//
//  ListCell.swift
//  shopping
//
//  Created by Akın Özcan on 21.12.2023.
//

import UIKit

final class ListCell: UITableViewCell {

    static let identifier = "ListCell"

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var basketButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!

    var isBasket: Bool = false

    var product: Product? {
        didSet {
            configure()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        product = nil
    }

    override func prepareForReuse() {
        product = nil
    }

    func configure() {
        guard let product = product else { return }

        productImageView.setImage(with: product.imageName)
        productNameLabel.text = product.name
        let currencySymbol = product.currency.getSymbol()
        productPriceLabel.text = "\(currencySymbol)\(product.price)"
        let isLiked = FavoritesManager.shared.isProductFavorite(id: product.id)
        setLikeButtonImage(isLiked: isLiked)
        
        updateButtonVisibility()
    }

    func updateButtonVisibility() {
        basketButton.isHidden = isBasket
        likeButton.isHidden = isBasket
    }

    func setLikeButtonImage(isLiked: Bool) {
        let imageName = isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"
        let image = UIImage(systemName: imageName)
        likeButton.setImage(image, for: .normal)
    }

    @IBAction func likeButtonClicked(_ sender: UIButton) {
        guard let productId = product?.id else { return }

        let isLiked = FavoritesManager.shared.isProductFavorite(id: productId)
        if isLiked {
            FavoritesManager.shared.unFavoriteProduct(id: productId)
        } else {
            FavoritesManager.shared.favoriteProduct(id: productId)
        }

        setLikeButtonImage(isLiked: !isLiked)
    }

    @IBAction func basketButtonClicked(_ sender: UIButton) {
        if let product = product {
            BasketManager.shared.addProduct(product: product)
        }
    }
}
