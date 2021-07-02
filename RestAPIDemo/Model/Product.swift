import Foundation
import RealmSwift

class ProdData: Object, Decodable
{
    @objc dynamic var code: Int = 0
    
    var prodData = List<Product>()
    
    override static func primaryKey() -> String?
    {
        return "code"
    }
}

class Product: Object, Decodable
{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var discount_amount: String = ""
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
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
