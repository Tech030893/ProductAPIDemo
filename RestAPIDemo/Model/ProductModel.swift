import Foundation

struct ProductModel: Codable
{
    let data: [ProductData]
}

struct ProductData: Codable
{
    let name: String
    let description: String
    let image: String
    let price: String
    let discount_amount: String
}
