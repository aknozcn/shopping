//
//  ListViewModel.swift
//  shopping
//
//  Created by Akın Özcan on 21.12.2023.
//

import Foundation

protocol ListViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    var productsList: [Product] { get }
}

protocol ListViewModelDelegate: AnyObject {
    func fetched()
    func setTitle(_ title: String)
    func reloadData()
}

final class ListViewModel: ListViewModelProtocol {
    private var products: [Product] = []
    weak var delegate: ListViewModelDelegate?

    var productsList: [Product] {
        return products
    }

    func viewDidLoad() {
        loadProducts()
        delegate?.setTitle("Product List")
    }

    func viewWillAppear() {
        delegate?.reloadData()
    }
}

private extension ListViewModel {
    func loadProducts() {
        guard let url = Bundle.main.url(forResource: "Products", withExtension: "json") else {
            fatalError("json not found")
        }

        do {
            let data = try Data(contentsOf: url)
            let products = try JSONDecoder().decode([Product].self, from: data)
            self.products = products.sorted(by: { $0.price < $1.price })
            self.delegate?.fetched()

        } catch {
            print("Error during JSON serialization: \(error.localizedDescription)")
        }
    }
}
