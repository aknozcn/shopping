//
//  ListViewController.swift
//  shopping
//
//  Created by Akın Özcan on 21.12.2023.
//

import UIKit

final class ListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    typealias ViewModel = ListViewModelProtocol
    var viewModel: any ViewModel

    private let dataSource = ListDataSource()

    init(viewModel: any ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupTableViewProperties()
        setDataSourceProperties()
        setNavigationBarProperties()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    static func generateRoutableViewController() -> UIViewController {
        let viewModel = ListViewModel()
        let view = ListViewController(viewModel: viewModel)

        viewModel.delegate = view
        return view
    }
}

private extension ListViewController {
    func setNavigationBarProperties() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket.fill"), style: .plain, target: self, action: #selector(basketButtonClicked))
    }

    func setupTableViewProperties() {
        let nib = UINib(nibName: ListCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListCell.identifier)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    func setDataSourceProperties() {
        dataSource.delegate = self
    }

    @objc func basketButtonClicked() {
        let basketViewController = BasketViewController.generateRoutableViewController()
        self.navigationController?.pushViewController(basketViewController, animated: true)
    }
}

extension ListViewController: ListViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }

    func setTitle(_ title: String) {
        self.title = title
    }

    func fetched() {
        dataSource.items = viewModel.productsList
    }
}

extension ListViewController: ListDataSourceDelegate {
    func navigateDetail(product: Product) {
        let detailViewController = DetailViewController.generateRoutableViewController(product: product)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

