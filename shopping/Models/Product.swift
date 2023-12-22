//
//  Product.swift
//  shopping
//
//  Created by Akın Özcan on 21.12.2023.
//

struct Product: Decodable {
    var id: Int
    var price: Double
    var name: String
    var category: String
    var currency: String
    var imageName: String
    var color: String

    enum CodingKeys: String, CodingKey {
        case id, price, name, category, currency, color
        case imageName = "image_name"
    }
}
