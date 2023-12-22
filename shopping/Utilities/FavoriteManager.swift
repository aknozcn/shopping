//
//  FavoriteManager.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import Foundation

final class FavoritesManager {

    static let shared = FavoritesManager()
    private init() { }
    private let defaults = UserDefaults.standard
    private let favoritesKey = "favorites"

    func favoriteProduct(id: Int) {
        var favorites = getFavorites()
        if !favorites.contains(id) {
            favorites.append(id)
            defaults.set(favorites, forKey: favoritesKey)
        }
        defaults.synchronize()
    }

    func isProductFavorite(id: Int) -> Bool {
        return getFavorites().contains(id)
    }

    func unFavoriteProduct(id: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            defaults.set(favorites, forKey: favoritesKey)
        }
        defaults.synchronize()
    }
    
    func removeAll() {
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        defaults.synchronize()
    }
}

private extension FavoritesManager {
    func getFavorites() -> [Int] {
        return defaults.array(forKey: favoritesKey) as? [Int] ?? []
    }
}
