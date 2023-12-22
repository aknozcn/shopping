//
//  ConfirmationViewController.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import UIKit

final class ConfirmationViewController: UIViewController {

    @IBOutlet private weak var totalItemCountLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!

    typealias ViewModel = ConfirmationViewModelProtocol
    var viewModel: any ViewModel

    init(viewModel: any ConfirmationViewModelProtocol) {
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

    static func generateRoutableViewController() -> UIViewController {
        let viewModel = ConfirmationViewModel()
        let view = ConfirmationViewController(viewModel: viewModel)

        viewModel.delegate = view
        return view
    }
}

private extension ConfirmationViewController {
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        viewModel.clear()
    }
}
extension ConfirmationViewController: ConfirmationViewModelDelegate {
    func navigateToList() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUI() {
        totalItemCountLabel.text = viewModel.itemCount
        totalAmountLabel.text = viewModel.totalAmount
    }

    func setTitle(_ title: String) {
        self.title = title
    }
}

