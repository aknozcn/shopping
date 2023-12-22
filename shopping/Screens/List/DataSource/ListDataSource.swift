//
//  ListDataSource.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import UIKit

protocol ListDataSourceDelegate: AnyObject {
    func navigateDetail(product: Product)
}

final class ListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView?
    weak var delegate: ListDataSourceDelegate?

    var items: [Product] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        cell.product = items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.navigateDetail(product: items[indexPath.row])
    }
}
