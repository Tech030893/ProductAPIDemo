import UIKit

class HomeViewController: UIViewController
{
    @IBOutlet weak var productTableView: UITableView!
    
    let productManager = ProductManager()
    
    var data = [ProductData]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        productManager.getProductData { data in
            self.data = data
            DispatchQueue.main.async
            {
                self.productTableView.reloadData()
            }
        }
    }
}

// MARK: - TableView Setup

extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "APIProductTableViewCell") as! APIProductTableViewCell
        
        cell.productNameLabel.text = data[indexPath.row].name
        cell.descriptionLabel.text = data[indexPath.row].description
        cell.originalPriceLabel.text = data[indexPath.row].price
        cell.discountPriceLabel.text = data[indexPath.row].discount_amount
        cell.productImageView.load(urlString: data[indexPath.row].image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }
}

extension UIImageView
{
    func load(urlString: String)
    {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url)
            {
                if let image = UIImage(data: data)
                {
                    DispatchQueue.main.async
                    {
                        self.image = image
                    }
                }
            }
        }
    }
}
