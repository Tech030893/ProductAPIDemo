import UIKit

class HomeViewController: UIViewController
{
    @IBOutlet weak var productTableView: UITableView!
    
    var productArray = [NSDictionary]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        productDataApi()
    }
    
    // MARK: - API Calling
    
    func productDataApi()
    {
        URLSession.shared.dataTask(with: URL(string: "https://gorest.co.in/public-api/products")!) { data, response, error in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data
            {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    let response = jsonResponse.value(forKey: "data") as! [NSDictionary]
                    self.productArray = response
                    DispatchQueue.main.async
                    {
                        self.productTableView.reloadData()
                    }
                } catch {
                    print("Exception Here")
                }
            }
        }.resume()
    }
}

// MARK: - TableView Setup

extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let dict = productArray
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "APIProductTableViewCell") as! APIProductTableViewCell
        
        let name = dict[indexPath.row].value(forKey: "name") as! String
        cell.productNameLabel.text = name
        
        let description = dict[indexPath.row].value(forKey: "description") as! String
        cell.descriptionLabel.text = description
        
        let originalPrice = dict[indexPath.row].value(forKey: "price") as! NSString
        cell.originalPriceLabel.text = String(originalPrice)
        
        let discountPrice = dict[indexPath.row].value(forKey: "discount_amount") as! NSString
        cell.discountPriceLabel.text = String(discountPrice)
        
        let image = dict[indexPath.row].value(forKey: "image") as! String
        cell.productImageView.load(urlString: image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }
}

// MARK: - Code to download image

extension UIImageView
{
    func load(urlString: String)
    {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url)
            {
                if let image = UIImage(data: data)
                {
                    DispatchQueue.main.async
                    {
                        self?.image = image
                    }
                }
            }
        }
    }
}
