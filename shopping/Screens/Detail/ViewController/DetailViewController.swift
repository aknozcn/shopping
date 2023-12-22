//
//  DetailViewController.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var colorLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var basketButton: UIButton!
    
    typealias ViewModel = DetailViewModelProtocol
    var viewModel: any ViewModel

    init(viewModel: any DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    static func generateRoutableViewController(product: Product) -> UIViewController {
        let viewModel = DetailViewModel(product: product)
        let view = DetailViewController(viewModel: viewModel)
        
        viewModel.delegate = view
        return view
    }
}

private extension DetailViewController {
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        viewModel.updateLikedProduct()
    }
    
    @IBAction func basketButtonClicked(_ sender: UIButton) {
        viewModel.addProduct()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func setLikeButtonImage(isLiked: Bool) {
        let imageName = isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"
        let image = UIImage(systemName: imageName)
        likeButton.setImage(image, for: .normal)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setUI() {
        productImageView.setImage(with: viewModel.product.imageName)
        productNameLabel.text = viewModel.product.name
        productPriceLabel.text = "\(viewModel.currency)\(viewModel.product.price)"
        categoryLabel.text = viewModel.product.category
        colorLabel.text = viewModel.product.color
    }
}
