//
//  BasketDataSource.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import UIKit

protocol BasketDataSourceDelegate: AnyObject {
    func reloadData()
}

final class BasketDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView?
    weak var delegate: BasketDataSourceDelegate?
    
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
        cell.isBasket = true
        cell.product = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .destructive, title: "Delete") {[weak self] action, view, completionHandler in
            guard let self = self else { return }
            BasketManager.shared.removeProduct(id: self.items[indexPath.row].id)
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.delegate?.reloadData()
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
