//
//  BasketViewController.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import UIKit

final class BasketViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var totalItemCountLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var checkOutButton: UIButton!
    
    typealias ViewModel = BasketViewModelProtocol
    var viewModel: any ViewModel

    private let dataSource = BasketDataSource()

    init(viewModel: any BasketViewModelProtocol) {
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
        viewModel.checkBasketIsNotEmpty()
        bottomView.setBottomViewShadow()
    }

    static func generateRoutableViewController() -> UIViewController {
        let viewModel = BasketViewModel()
        let view = BasketViewController(viewModel: viewModel)

        viewModel.delegate = view
        return view
    }
}

private extension BasketViewController {
    func setupTableViewProperties() {
        let nib = UINib(nibName: ListCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListCell.identifier)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    func setDataSourceProperties() {
        dataSource.delegate = self
    }
    
    @IBAction func checkOutButtonClicked(_ sender: UIButton) {
        let confirmationViewController = ConfirmationViewController.generateRoutableViewController()
        self.navigationController?.pushViewController(confirmationViewController, animated: true)
    }
}

extension BasketViewController: BasketViewModelDelegate {
    func updateCheckOutButton(isEnable: Bool) {
        checkOutButton.isEnabled = isEnable
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setUI() {
        totalItemCountLabel.text = viewModel.itemCount
        totalAmountLabel.text = viewModel.totalAmount
    }

    func getProductList(products: [Product]) {
        dataSource.items = products
    }
}

extension BasketViewController: BasketDataSourceDelegate {
    func reloadData() {
        setUI()
        viewModel.checkBasketIsNotEmpty()
    }
}

