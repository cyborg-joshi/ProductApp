//
//  ProductListViewController.swift
//  ProductApp
//
//  Created by KANISHK on 10/06/24.
//

import UIKit

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: String
}

struct ProductResponse: Decodable {
    let products: [Product]
}


class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var products: [Product] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupTableView()
            fetchProducts()
        }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "titleCell")
    }

    func fetchProducts() {
        let url = URL(string: "https://dummyjson.com/products")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching products: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ProductResponse.self, from: data)
                self.products = response.products
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.title
        cell.imageView?.image = UIImage(named: "placeholder") // Placeholder image

        // Asynchronously load the thumbnail image
        if let imageURL = URL(string: product.thumbnail) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            cell.imageView?.image = image
                            cell.setNeedsLayout()
                        }
                    }
                }
            }.resume()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        performSegue(withIdentifier: "ShowProductDetail", sender: product)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductDetail",
           let destinationVC = segue.destination as? ProductDetailViewController,
           let product = sender as? Product {
            destinationVC.product = product
        }
    }
}
