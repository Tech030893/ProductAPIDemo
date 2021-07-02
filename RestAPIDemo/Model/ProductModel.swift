import Foundation
import RealmSwift

class ProductModel: Codable
{
    let data: [ProductData]
}

class ProductData: Codable
{
    let id: Int
    let name: String
    let desc: String
    let image: String
    let price: String
    let discount_amount: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
        case desc = "description"
        case image = "image"
        case price = "price"
        case discount_amount = "discount_amount"
    }
}
