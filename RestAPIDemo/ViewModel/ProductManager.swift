import Foundation

struct ProductManager
{
    func getProductData(completion: @escaping ([ProductData]) -> ())
    {
        let url = URL(string: "https://gorest.co.in/public-api/products")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil
            {
                print(error?.localizedDescription)
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(ProductModel.self, from: data!)
                print(jsonResponse)
                completion(jsonResponse.data)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
